import json
import yaml
import argparse
import os

import pandas as pd

# Parse command line arguments
def parseArguments():
  parser = argparse.ArgumentParser(description='This script analyzes the results of a MetricAlertsRules query.')
  parser.add_argument('-q', '--query-results', type=str, required=False, metavar='file', help='Path to analyze results', default='analysis_results.csv')
  parser.add_argument('-p', '--provider-list', type=str, required=False, metavar='file', help='Path to provider list', default='provider_list.json')
  parser.add_argument('-m', '--parse-metrics', type=str, required=False, metavar='dir', help='Path to Azure repo containing metric definitions', default="../../../azure-reference-other/azure-monitor-ref/supported-metrics/includes")
  parser.add_argument('-l', '--load-metrics', type=str, required=False, metavar='file', help='Path to  metric definitions', default="metric_definitions.json")
  parser.add_argument('-s', '--save-metrics', type=str, required=False, metavar='file', help='Path to  metric definitions', default="metric_definitions.json")
  parser.add_argument('-a', '--amba-dir', type=str, required=False, metavar='file', help='Path to  metric definitions', default="../..")
  parser.add_argument('-t', '--threshold', type=str, required=False, metavar='file', help='Set minimum number for rules in order to be included in output', default=250)

  args = parser.parse_args()

  return args

# Output the alerts to a JSON file
def outputToJsonFile(data, filename):
  # Write the results to a file
  with open(filename, "w+") as f:
      json.dump(data, f, indent=2)

# Output the query results to a JSON file
def outputToYamlFile(data, filename):
  # Write the results to a file
  with open(filename, "w+") as f:
      yaml.dump(data, f, indent=2, default_flow_style=False, sort_keys=False)

def getResourceTypes(file):
  with open(file, "r", encoding="utf-8") as file:
    providers = json.load(file)

    # Get a list of resource types from the provider list
    resourceTypes = {}

    for p in providers:
      category = p["namespace"]
      if (category.startswith('Microsoft')):
        for rt in p["resourceTypes"]:
          type = rt["resourceType"]
          resourceTypes[f"{category}/{type}".lower()] = {
            "category": category,
            "type": type
          }

  return resourceTypes

def parseMetricFile(file):
  metrics = {}

  with open(file, 'r', encoding="utf-8") as f:
    lines = f.readlines()

  # Remove lines that don't begin with |
  lines = [line for line in lines if line.startswith('|')]

  # remove second line
  lines.pop(1)

  header = lines[0].split('|')
  header = [item.strip() for item in header if  item.strip() != '']

  for line in lines[1:]:
    line = line.split('|')
    line = line[1:-1]
    line = [item.strip() for item in line]

    metric = {}
    for i in range(len(header)):
      metric[header[i]] = line[i]

    metric['Description'] = metric.pop("Metric").split('<p>')[-1]
    key = metric['Name'].replace('`',  '')
    metric.pop('Name')

    metrics[key] = metric

  return metrics

def parseMetricFiles(dir):

  metricDefinitions = {}

  # Loop through each file in the directory
  for filename in os.listdir(dir):
    if filename.endswith(".md"):

      category = '.'.join(filename.split('-')[0:2])
      type = '/'.join(filename.split('-')[2:-2])
      file = os.path.join(dir, filename)
      metrics = parseMetricFile(file)

      # Check if category and type are in resourceTypes case insensitive
      key = f"{category}/{type}".lower()
      metricDefinitions[key] = metrics

  return metricDefinitions

def parseAnalysisFile(file, resourceTypes):
  # Read the CSV file using Pandas
  alerts = pd.read_csv(file, header=0).to_dict('records')


  for alert in alerts:
    type = alert['resourceType']
    metric = alert['metricName']

    # Check if the metric is in the metrics list for each resource type
    if type in resourceTypes.keys():
      if 'metrics' in resourceTypes[type].keys():
        # find key in metrics that matches lowercase metric name
        key = [k for k in resourceTypes[type]['metrics'].keys() if k.lower() == metric.lower()]
        if len(key) > 0:
          # drop first keys in alert
          alert.pop('resourceType')
          alert.pop('metricName')
          resourceTypes[type]['metrics'][key[0]]['alert'] = alert
        else:
          print(f"Did not find metric: {metric} in {type}")

def formatOperator(value):
  match value.lower():
    case 'lessthan':
      return 'LessThan'
    case 'lessthanorequal':
      return 'LessThanOrEqual'
    case 'greaterthan':
      return 'GreaterThan'
    case 'greaterthanorequal':
      return 'GreaterThanOrEqual'
    case 'greaterorlessthan':
      return 'GreaterOrLessThan'
    case 'equal':
      return 'Equal'
    case _:
      return value

def formatCriterion(value):
  match value.lower():
    case 'staticthresholdcriterion':
      return 'StaticThresholdCriterion'
    case 'dynamicthresholdcriterion':
      return 'DynamicThresholdCriterion'
    case _:
      return value

def main():

  args = parseArguments()

  resourceTypes = getResourceTypes(args.provider_list)

  metricDefinitions = {}
  if args.load_metrics:
    with open(args.load_metrics, "r", encoding="utf-8") as file:
      metricDefinitions = json.load(file)
  else:
    metricDefinitions = parseMetricFiles(args.parse_metrics)
    outputToJsonFile(metricDefinitions, args.save_metrics)

  # add metrics to resourceTypes
  for key in metricDefinitions:
    if not key in resourceTypes.keys():
      print(f"Did not find resource type: {key}")
      continue

    resourceTypes[key]['metrics'] = metricDefinitions[key]

  parseAnalysisFile(args.query_results, resourceTypes)

  # remove metrics that don't have alerts
  for rt in resourceTypes:
    if not 'metrics' in resourceTypes[rt].keys(): continue

    for metric in list(resourceTypes[rt]['metrics']):
      if not 'alert' in resourceTypes[rt]['metrics'][metric].keys():
        resourceTypes[rt]['metrics'].pop(metric)

  dir = '../../services'
  for rt in resourceTypes:
    if not 'metrics' in resourceTypes[rt].keys(): continue

    # sort metrics based on alert numRules descending if alerts exist
    resourceTypes[rt]['metrics'] = dict(sorted(resourceTypes[rt]['metrics'].items(), key=lambda item: item[1]['alert']['numRules'], reverse=True))

    for metric in resourceTypes[rt]["metrics"]:
      if not 'alert' in resourceTypes[rt]["metrics"][metric].keys(): continue

      if resourceTypes[rt]["metrics"][metric]["alert"]["numRules"] < args.threshold: continue

      category = resourceTypes[rt]['category']
      type = resourceTypes[rt]['type']
      alert = resourceTypes[rt]["metrics"][metric]["alert"]
      description = resourceTypes[rt]["metrics"][metric]["Description"]

      # create directory based on category if it doesn't exist
      category = resourceTypes[rt]['category'].replace('Microsoft.', '')
      if not os.path.exists(os.path.join(dir, category, '_index.md')):
        os.makedirs(os.path.join(dir, category), exist_ok=True)

      with open(os.path.join(dir, category, '_index.md'), 'w+') as f:
        f.write(f"---\ntitle: {category}\ngeekdocCollapseSection: true\ngeekdocHidden: false\n---\n")

      # create directory based on type if it doesn't exist
      subdir = type.split('/')[0]
      if not os.path.exists(os.path.join(dir, category, subdir, '_index.md')):
        os.makedirs(os.path.join(dir, category, subdir), exist_ok=True)

      with open(os.path.join(dir, category, subdir, '_index.md'), 'w+') as f:
        f.write(f"---\ntitle: {subdir}\ngeekdocCollapseSection: true\ngeekdocHidden: false\n---\n\n")
        f.write('{{< alertList name="alertList" >}}')

      # load existing yaml file if it exists
      filename = os.path.join(dir, category, subdir, "alerts.yaml")
      if not os.path.exists(filename):
        mode = 'w'
      else:
        mode = 'r+'

      with open(filename, mode) as f:
        try:
          data = yaml.load(f, Loader=yaml.FullLoader)
        except:
          data = []


        # remove all alerts that have a tag of auto-generated and is not visible
        for i in range(len(data)):
          if data[i]['type'] != 'Metric': continue
          if "tags" not in data[i].keys(): continue

          if 'auto-generated' in data[i]['tags']:
            if data[i]["visible"] == False:
              data.pop(i)
              break

        addAlert = True

        name = metric
        # if type has more than one segment, slice off the first segment
        if len(type.split('/')) > 1:
          name = f"{'/'.join(type.split('/')[1:])} - {metric}"

        # Find record where proerpites.metricName == metric
        for i in range(len(data)):
          if data[i]['type'] == 'Metric':
            if data[i]['name'] == name:
              data[i]['description'] = description
              break

        popped_alert = None
        # find record where properties.metricName == metric and tag contains auto-generated
        for i in range(len(data)):
          if data[i]['type'] != 'Metric': continue
          if "tags" not in data[i].keys(): continue

          if data[i]['properties']['metricName'] == metric and 'auto-generated' in data[i]['tags']:
            if data[i]['verified'] == False:
              popped_alert = data.pop(i)
              break
            else:
              addAlert = False
              break

        if addAlert:
          # add alert to yaml file
          new_alert = {
            "name": name,
            "description": description,
            "type": "Metric",
            "verified": False,
            "visible": True,
            "tags": ["auto-generated", f"agc-{alert['numRules']}"],
            "properties": {
              "metricName": metric,
              "metricNamespace": f"{resourceTypes[rt]['category']}/{type}",
              "severity": alert['severity'],
              "windowSize": alert['windowSize'],
              "evaluationFrequency": alert['frequency'],
              "timeAggregation": alert['timeAggregation'].capitalize(),
              "operator": formatOperator(alert['operator']),
              "criterionType": formatCriterion(alert['criterionType']),
            }
          }

          if popped_alert:
            if 'references' in popped_alert.keys():
              new_alert['references'] = popped_alert['references']

          if 'dimensions' in alert.keys():
            if alert['dimensions'] != '[]':
              new_alert['properties']['dimensions'] = json.loads(alert['dimensions'])

          if new_alert['properties']['criterionType'] == 'DynamicThresholdCriterion':
            new_alert['properties']['failingPeriods'] = json.loads(alert['failingPeriods'])
            new_alert['properties']['alertSensitivity'] = alert['alertSensitivity'].capitalize()
          else:
            new_alert['properties']['threshold'] = alert['threshold']

          data.append(new_alert)

        # write yaml file
        outputToYamlFile(data, filename)

      print(f"Adding alert defintion: resource: {category}/{type} metric: {metric} numRules: {alert['numRules']}")

if __name__ == "__main__":
  main()
