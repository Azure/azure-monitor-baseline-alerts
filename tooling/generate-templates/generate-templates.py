import os
import yaml
import json
import argparse

# Parse command line arguments
def parseArguments():
  parser = argparse.ArgumentParser(description='This script will generate ARM and Bicep templates for each alert.')
  parser.add_argument('-p', '--path', type=str, required=False, metavar='path', help='Path to services directory', default='../../services')
  parser.add_argument('-o', '--output', type=str, required=False, metavar='output', help='Path to output directory', default='../../services')
  parser.add_argument('-s', '--template_path', type=str, required=False, metavar='template_path', help='Path to templates directory', default='templates')
  parser.add_argument('-t', '--telemetry_pid', type=str, required=False, metavar='telemetry_pid', help='Telemetry PID', default='pid-8bb7cf8a-bcf7-4264-abcb-703ace2fc84d')
  args = parser.parse_args()

  return args

def readYamlData(dir, export_hidden):

  # Walk the directory tree and load all the alerts.yaml files
  # into a list of dictionaries using the folder path as the structure
  # for the dictionary.
  data = {}
  for root, dirs, files in os.walk(dir):
    for file in files:
      if file == 'alerts.yaml':
        with open(os.path.join(root, file)) as f:
          # Get current folder name and parent folder name
          # to use as keys in the dictionary
          resourceType = os.path.basename(root)
          resouceCategory = os.path.basename(os.path.dirname(root))

          if not resouceCategory in data:
            data[resouceCategory] = {}

          if not resourceType in data[resouceCategory]:
            data[resouceCategory][resourceType] = []

          alerts = yaml.safe_load(f)
          if alerts:
            for alert in alerts:
              if (not export_hidden) and ('visible' in alert) and (alert['visible'] == False):
                continue
              data[resouceCategory][resourceType].append(alert)

  return data

def readTemplates(template_path):
  arm = {}
  bicep = {}

  # Read ARM templates from arm directory into a string
  for root, dirs, files in os.walk(os.path.join(template_path, 'arm')):
    for file in files:
      if file.endswith('.json'):
        # read the file into a string
        with open(os.path.join(root, file)) as f:
          arm[file.replace('.json','')] = f.read()

  # Read Bicep templates from arm directory into a string
  for root, dirs, files in os.walk(os.path.join(template_path, 'bicep')):
    for file in files:
      if file.endswith('.bicep'):
        # read the file into a string
        with open(os.path.join(root, file)) as f:
          bicep[file.replace('.bicep','')] = f.read()

  return arm, bicep

def main():

  args = parseArguments()

  data = readYamlData(args.path, False)

  arm, bicep = readTemplates(args.template_path)

  import datetime
  import re

  for category in data:
    for resourceType in data[category]:

      print(f"Generating templates for {len(data[category][resourceType])} alerts in {category}/{resourceType}...")

      # create directories based on template types if it doesn't exist
      os.makedirs(os.path.join(args.output, category, resourceType, "templates", "arm"), exist_ok=True)
      os.makedirs(os.path.join(args.output, category, resourceType, "templates", "bicep"), exist_ok=True)

      # Remove all files in arm and bicep directories
      for root, dirs, files in os.walk(os.path.join(args.output, category, resourceType, "templates", "arm")):
        for file in files:
          os.remove(os.path.join(root, file))

      for root, dirs, files in os.walk(os.path.join(args.output, category, resourceType, "templates", "bicep")):
        for file in files:
          os.remove(os.path.join(root, file))

      alert_file_names = []

      for alert in data[category][resourceType]:
        arm_template_type = ""
        alert_file_name = re.sub(r'[^a-zA-Z0-9-]', '', alert['name']) + '_' + alert['guid']

        if alert["type"] == "Metric":
          if 'criterionType' in alert["properties"]:
            if alert["properties"]["criterionType"] == "StaticThresholdCriterion":
              template_type = "metric-static"
            else:
              template_type = "metric-dynamic"
          else:
            print(f"CriterionType not found for alert {alert['guid']}")
        elif alert["type"] == "Log":
          template_type = "log"
        elif alert["type"] == "ActivityLog":
          if alert["properties"]["category"] == "Administrative":
            template_type = "activity-administrative"
          elif alert["properties"]["category"] == "ResourceHealth":
            template_type = "activity-resourcehealth"
          elif alert["properties"]["category"] == "ServiceHealth":
            template_type = "activity-servicehealth"
        else:
          continue

        if template_type == "":
          print(f"Template not found for alert {alert['guid']}")
        else:
          # Generate ARM template
          arm_template = arm[template_type]
          bicep_template = bicep[template_type]

          arm_template = arm_template.replace("##TELEMETRY_PID##", args.telemetry_pid)
          bicep_template = bicep_template.replace("##TELEMETRY_PID##", args.telemetry_pid)

          if 'description' in alert and alert["description"] is not None:
            arm_template = arm_template.replace("##DESCRIPTION##", alert["description"])
            bicep_template = bicep_template.replace("##DESCRIPTION##", alert["description"])
          else:
            arm_template = arm_template.replace("##DESCRIPTION##", "")
            bicep_template = bicep_template.replace("##DESCRIPTION##", "")

          if 'severity' in alert["properties"] and alert["properties"]["severity"] is not None:
            arm_template = arm_template.replace("##SEVERITY##", str(int(alert["properties"]["severity"])))
            bicep_template = bicep_template.replace("##SEVERITY##", str(int(alert["properties"]["severity"])))
          else:
            arm_template = arm_template.replace("##SEVERITY##", "")
            bicep_template = bicep_template.replace("##SEVERITY##", "")

          if 'autoMitigate' in alert["properties"] and alert["properties"]["autoMitigate"] is not None:
            if alert["properties"]["autoMitigate"] == True:
              arm_template = arm_template.replace("##AUTO_MITIGATE##", "true")
              bicep_template = bicep_template.replace("##AUTO_MITIGATE##", "true")
            else:
              arm_template = arm_template.replace("##AUTO_MITIGATE##", "False")
              bicep_template = bicep_template.replace("##AUTO_MITIGATE##", "false")
          else:
            arm_template = arm_template.replace("##AUTO_MITIGATE##", "")
            bicep_template = bicep_template.replace("##AUTO_MITIGATE##", "")

          if 'query' in alert["properties"] and alert["properties"]["query"] is not None:
            arm_template = arm_template.replace("##QUERY##", json.dumps(alert["properties"]["query"].replace("\n", " ")))
            query = alert["properties"]["query"].replace("\n", " ").replace("'", "\\'")
            bicep_template = bicep_template.replace("##QUERY##", query)
          else:
            arm_template = arm_template.replace("##QUERY##", "")
            bicep_template = bicep_template.replace("##QUERY##", "")

          if 'metricName' in alert["properties"] and alert["properties"]["metricName"] is not None:
            arm_template = arm_template.replace("##METRIC_NAME##", alert["properties"]["metricName"])
            bicep_template = bicep_template.replace("##METRIC_NAME##", alert["properties"]["metricName"])
          else:
            arm_template = arm_template.replace("##METRIC_NAME##", "")
            bicep_template = bicep_template.replace("##METRIC_NAME##", "")

          if 'metricMeasureColumn' in alert["properties"] and alert["properties"]["metricMeasureColumn"] is not None:
            arm_template = arm_template.replace("##METRIC_MEASURE_COLUMN##", alert["properties"]["metricMeasureColumn"])
            bicep_template = bicep_template.replace("##METRIC_MEASURE_COLUMN##", alert["properties"]["metricMeasureColumn"])
          else:
            arm_template = arm_template.replace("##METRIC_MEASURE_COLUMN##", "")
            bicep_template = bicep_template.replace("##METRIC_MEASURE_COLUMN##", "")

          if 'resouceIdColumn' in alert["properties"] and alert["properties"]["resouceIdColumn"] is not None:
            arm_template = arm_template.replace("##RESOURCE_ID_COLUMN##", alert["properties"]["resouceIdColumn"])
            bicep_template = bicep_template.replace("##RESOURCE_ID_COLUMN##", alert["properties"]["resouceIdColumn"])
          else:
            arm_template = arm_template.replace("##RESOURCE_ID_COLUMN##", "")
            bicep_template = bicep_template.replace("##RESOURCE_ID_COLUMN##", "")

          if 'operator' in alert["properties"] and alert["properties"]["operator"] is not None:
            arm_template = arm_template.replace("##OPERATOR##", alert["properties"]["operator"])
            bicep_template = bicep_template.replace("##OPERATOR##", alert["properties"]["operator"])
          else:
            arm_template = arm_template.replace("##OPERATOR##", "")
            bicep_template = bicep_template.replace("##OPERATOR##", "")

          if 'failingPeriods' in alert["properties"] and alert["properties"]["failingPeriods"]["numberOfEvaluationPeriods"] is not None:
            arm_template = arm_template.replace("##FAILING_PERIODS_NUMBER_OF_EVALUATION_PERIODS##", str(int(alert["properties"]["failingPeriods"]["numberOfEvaluationPeriods"])))
            bicep_template = bicep_template.replace("##FAILING_PERIODS_NUMBER_OF_EVALUATION_PERIODS##", str(int(alert["properties"]["failingPeriods"]["numberOfEvaluationPeriods"])))
          else:
            arm_template = arm_template.replace("##FAILING_PERIODS_NUMBER_OF_EVALUATION_PERIODS##", "")
            bicep_template = bicep_template.replace("##FAILING_PERIODS_NUMBER_OF_EVALUATION_PERIODS##", "")

          if 'failingPeriods' in alert["properties"] and alert["properties"]["failingPeriods"]["numberOfEvaluationPeriods"] is not None:
            arm_template = arm_template.replace("##FAILING_PERIODS_MIN_FAILING_PERIODS_TO_ALERT##", str(int(alert["properties"]["failingPeriods"]["minFailingPeriodsToAlert"])))
            bicep_template = bicep_template.replace("##FAILING_PERIODS_MIN_FAILING_PERIODS_TO_ALERT##", str(int(alert["properties"]["failingPeriods"]["minFailingPeriodsToAlert"])))
          else:
            arm_template = arm_template.replace("##FAILING_PERIODS_MIN_FAILING_PERIODS_TO_ALERT##", "")
            bicep_template = bicep_template.replace("##FAILING_PERIODS_MIN_FAILING_PERIODS_TO_ALERT##", "")

          if 'threshold' in alert["properties"] and alert["properties"]["threshold"] is not None:
            # Convert the threshold to a float
            threshold = float(alert["properties"]["threshold"])
            threshold = str(round(threshold))
            if threshold == "":
              raise Exception(f"Threshold is empty for alert {alert['guid']}")

            arm_template = arm_template.replace("##THRESHOLD##", threshold)
            bicep_template = bicep_template.replace("##THRESHOLD##", threshold)
          else:
            arm_template = arm_template.replace("##THRESHOLD##", "")
            bicep_template = bicep_template.replace("##THRESHOLD##", "")

          if 'timeAggregation' in alert["properties"] and alert["properties"]["timeAggregation"] is not None:
            arm_template = arm_template.replace("##TIME_AGGREGATION##", alert["properties"]["timeAggregation"])
            bicep_template = bicep_template.replace("##TIME_AGGREGATION##", alert["properties"]["timeAggregation"])
          else:
            arm_template = arm_template.replace("##TIME_AGGREGATION##", "")
            bicep_template = bicep_template.replace("##TIME_AGGREGATION##", "")

          if 'windowSize' in alert["properties"] and alert["properties"]["windowSize"] is not None:
            arm_template = arm_template.replace("##WINDOW_SIZE##", alert["properties"]["windowSize"])
            bicep_template = bicep_template.replace("##WINDOW_SIZE##", alert["properties"]["windowSize"])
          else:
            arm_template = arm_template.replace("##WINDOW_SIZE##", "")
            bicep_template = bicep_template.replace("##WINDOW_SIZE##", "")

          if 'evaluationFrequency' in alert["properties"] and alert["properties"]["evaluationFrequency"] is not None:
            arm_template = arm_template.replace("##EVALUATION_FREQUENCY##", alert["properties"]["evaluationFrequency"])
            bicep_template = bicep_template.replace("##EVALUATION_FREQUENCY##", alert["properties"]["evaluationFrequency"])
          else:
            arm_template = arm_template.replace("##EVALUATION_FREQUENCY##", "")
            bicep_template = bicep_template.replace("##EVALUATION_FREQUENCY##", "")

          if 'dimensions' in alert["properties"] and alert["properties"]["dimensions"] is not None:
            arm_template = arm_template.replace("##DIMENSIONS##", json.dumps(alert["properties"]["dimensions"]))

            dimensions = []
            for dimension in alert["properties"]["dimensions"]:
              values = []
              for value in dimension["values"]:
                values.append(f"'{value}'")

              dimensions.append(f"""
            {{
              name: '{dimension["name"]}'
              operator: '{dimension["operator"]}'
              values: [{",".join(values)}]
            }}""")

            bicep_template = bicep_template.replace("##DIMENSIONS##", "".join(dimensions))
          else:
            arm_template = arm_template.replace("##DIMENSIONS##", "[]")
            bicep_template = bicep_template.replace("##DIMENSIONS##", "[]")

          if 'operationName' in alert["properties"] and alert["properties"]["operationName"] is not None:
            arm_template = arm_template.replace("##OPERATION_NAME##", alert["properties"]["operationName"])
            bicep_template = bicep_template.replace("##OPERATION_NAME##", alert["properties"]["operationName"])
          else:
            arm_template = arm_template.replace("##OPERATION_NAME##", "")
            bicep_template = bicep_template.replace("##OPERATION_NAME##", "")

          if 'status' in alert["properties"] and alert["properties"]["status"] is not None:
            arm_template = arm_template.replace("##STATUS##", json.dumps(alert["properties"]["status"]))

            statuses = []
            for status in alert["properties"]["status"]:
                statuses.append(f"'{status}'")

            bicep_template = bicep_template.replace("##STATUS##", f"[{",".join(statuses)}]")
          else:
            arm_template = arm_template.replace("##STATUS##", "")
            bicep_template = bicep_template.replace("##STATUS##", "")

          if 'causes' in alert["properties"] and alert["properties"]["causes"] is not None:

            causes = []
            for cause in alert["properties"]["causes"]:
              causes.append(f"""
                {{
                  "field": "properties.cause",
                  "equals": "{cause}"
                }}""")

            arm_template = arm_template.replace("##CAUSES##", f"{",".join(causes)}")

            causes = []
            for cause in alert["properties"]["causes"]:
              causes.append(f"""
            {{
              field: 'properties.cause'
              equals: '{cause}'
            }}""")

            bicep_template = bicep_template.replace("##CAUSES##", f"{"".join(causes)}")
          else:
            arm_template = arm_template.replace("##CAUSES##", "")
            bicep_template = bicep_template.replace("##CAUSES##", "")

          if 'currentHealthStatus' in alert["properties"] and alert["properties"]["currentHealthStatus"] is not None:
            currentHealthStatuses = []
            for currentHealthStatus in alert["properties"]["currentHealthStatus"]:
              currentHealthStatuses.append(f"""
                {{
                  "field": "properties.currentHealthStatus",
                  "equals": "{currentHealthStatus}"
                }}""")

            arm_template = arm_template.replace("##CURRENT_HEALTH_STATUS##", f"{",".join(currentHealthStatuses)}")

            currentHealthStatuses = []
            for currentHealthStatus in alert["properties"]["currentHealthStatus"]:
              currentHealthStatuses.append(f"""
            {{
              field: 'properties.currentHealthStatus'
              equals: '{currentHealthStatus}'
            }}""")

            bicep_template = bicep_template.replace("##CURRENT_HEALTH_STATUS##", f"{"".join(currentHealthStatuses)}")
          else:
            arm_template = arm_template.replace("##CURRENT_HEALTH_STATUS##", "")
            bicep_template = bicep_template.replace("##CURRENT_HEALTH_STATUS##", "")

          if 'incidentType' in alert["properties"] and alert["properties"]["incidentType"] is not None:
            arm_template = arm_template.replace("##INCIDENT_TYPE##", alert["properties"]["incidentType"])
            bicep_template = bicep_template.replace("##INCIDENT_TYPE##", alert["properties"]["incidentType"])
          else:
            arm_template = arm_template.replace("##INCIDENT_TYPE##", "")
            bicep_template = bicep_template.replace("##INCIDENT_TYPE##", "")

          # Check if alert name already exists
          if alert_file_name in alert_file_names:
            raise Exception(f"Alert name {alert_file_name} already exists in the list of alerts for {category}/{resourceType}")
          else:
            alert_file_names.append(alert_file_name)

          with open(os.path.join(args.output, category, resourceType, "templates", "arm", alert_file_name + '.json'), 'w') as f:
            f.write(arm_template)

          # Save the Bicep template
          with open(os.path.join(args.output, category, resourceType, "templates", "bicep", alert_file_name + '.bicep'), 'w') as f:
            f.write(bicep_template)

if __name__ == '__main__':
  main()
