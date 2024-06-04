import os
import yaml
import json
import argparse
import datetime

# Parse command line arguments
def parseArguments():
  parser = argparse.ArgumentParser(description='This script will generate ARM and Bicep templates for each alert.')
  parser.add_argument('-p', '--path', type=str, required=False, metavar='path', help='Path to services directory', default='../../services')
  parser.add_argument('-o', '--output', type=str, required=False, metavar='output', help='Path to output directory', default='../../artifacts/templates')
  parser.add_argument('-t', '--telemetry_pid', type=str, required=False, metavar='telemetry_pid', help='Telemetry PID', default='pid-8bb7cf8a-bcf7-4264-abcb-703ace2fc84d')
  args = parser.parse_args()

  return args

def readYamlData(dir, export_hidden):

  # Walk the directory tree and load all the alerts.yaml files
  # into a list of dictionaries using the folder path as the structure
  # for the dictionary.  This will allow us to easily export the data
  # to a CSV or XLS file.
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

def readTemplates():
  arm = {}
  bicep = {}

  # Read ARM templates from arm directory into a string
  for root, dirs, files in os.walk(os.path.join('.', 'arm')):
    for file in files:
      if file.endswith('.json'):
        # read the file into a string
        with open(os.path.join(root, file)) as f:
          arm[file.replace('.json','')] = f.read()

  # Read Bicep templates from arm directory into a string
  for root, dirs, files in os.walk(os.path.join('.', 'bicep')):
    for file in files:
      if file.endswith('.bicep'):
        # read the file into a string
        with open(os.path.join(root, file)) as f:
          bicep[file.replace('.bicep','')] = f.read()

  return arm, bicep

def main():

  args = parseArguments()

  data = readYamlData(args.path, False)

  arm, bicep = readTemplates()

  import datetime

  # Get the current timestamp
  timestamp = datetime.datetime.now()

  # Format it as a string
  formatted_timestamp = timestamp.strftime("%Y%m%d%H%M%S")

  # Create the output directory if it doesn't exist
  os.makedirs(args.output, exist_ok=True)

  # Write timestamp to a file
  with open(os.path.join(args.output, 'latest_version.txt'), 'w') as f:
    f.write(formatted_timestamp)

  for category in data:
    for resourceType in data[category]:
      # create directory based on resourceType if it doesn't exist
      os.makedirs(os.path.join(args.output, formatted_timestamp, category, resourceType), exist_ok=True)

      for alert in data[category][resourceType]:
        arm_template_type = ""
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

        if template_type == "":
          print(f"Template not found for alert {alert['guid']}")
        else:
          # Generate ARM template
          arm_template = arm[template_type]
          bicep_template = bicep[template_type]

          arm_template = arm_template.replace("##TELEMETRY_PID##", args.telemetry_pid)
          bicep_template = bicep_template.replace("##TELEMETRY_PID##", args.telemetry_pid)

          if 'description' in alert and alert["description"]:
            arm_template = arm_template.replace("##DESCRIPTION##", alert["description"])
            bicep_template = bicep_template.replace("##DESCRIPTION##", alert["description"])
          else:
            arm_template = arm_template.replace("##DESCRIPTION##", "")
            bicep_template = bicep_template.replace("##DESCRIPTION##", "")

          if 'severity' in alert["properties"] and alert["properties"]["severity"]:
            arm_template = arm_template.replace("##SEVERITY##", str(int(alert["properties"]["severity"])))
            bicep_template = bicep_template.replace("##SEVERITY##", str(int(alert["properties"]["severity"])))
          else:
            arm_template = arm_template.replace("##SEVERITY##", "")
            bicep_template = bicep_template.replace("##SEVERITY##", "")

          if 'autoMitigate' in alert["properties"] and alert["properties"]["autoMitigate"]:
            if alert["properties"]["autoMitigate"] == True:
              arm_template = arm_template.replace("##AUTO_MITIGATE##", "true")
              bicep_template = bicep_template.replace("##AUTO_MITIGATE##", "true")
            else:
              arm_template = arm_template.replace("##AUTO_MITIGATE##", "False")
              bicep_template = bicep_template.replace("##AUTO_MITIGATE##", "false")
          else:
            arm_template = arm_template.replace("##AUTO_MITIGATE##", "")
            bicep_template = bicep_template.replace("##AUTO_MITIGATE##", "")

          if 'query' in alert["properties"] and alert["properties"]["query"]:
            arm_template = arm_template.replace("##QUERY##", json.dumps(alert["properties"]["query"].replace("\n", " ")))
            query = alert["properties"]["query"].replace("\n", " ").replace("'", "\\'")
            bicep_template = bicep_template.replace("##QUERY##", query)
          else:
            arm_template = arm_template.replace("##QUERY##", "")
            bicep_template = bicep_template.replace("##QUERY##", "")

          if 'metricMeasureColumn' in alert["properties"] and alert["properties"]["metricMeasureColumn"]:
            arm_template = arm_template.replace("##METRIC_MEASURE_COLUMN##", alert["properties"]["metricMeasureColumn"])
            bicep_template = bicep_template.replace("##METRIC_MEASURE_COLUMN##", alert["properties"]["metricMeasureColumn"])
          else:
            arm_template = arm_template.replace("##METRIC_MEASURE_COLUMN##", "")
            bicep_template = bicep_template.replace("##METRIC_MEASURE_COLUMN##", "")

          if 'resouceIdColumn' in alert["properties"] and alert["properties"]["resouceIdColumn"]:
            arm_template = arm_template.replace("##RESOURCE_ID_COLUMN##", alert["properties"]["resouceIdColumn"])
            bicep_template = bicep_template.replace("##RESOURCE_ID_COLUMN##", alert["properties"]["resouceIdColumn"])
          else:
            arm_template = arm_template.replace("##RESOURCE_ID_COLUMN##", "")
            bicep_template = bicep_template.replace("##RESOURCE_ID_COLUMN##", "")

          if 'operator' in alert["properties"] and alert["properties"]["operator"]:
            arm_template = arm_template.replace("##OPERATOR##", alert["properties"]["operator"])
            bicep_template = bicep_template.replace("##OPERATOR##", alert["properties"]["operator"])
          else:
            arm_template = arm_template.replace("##OPERATOR##", "")
            bicep_template = bicep_template.replace("##OPERATOR##", "")

          if 'failingPeriods' in alert["properties"] and alert["properties"]["failingPeriods"]["numberOfEvaluationPeriods"]:
            arm_template = arm_template.replace("##FAILING_PERIODS_NUMBER_OF_EVALUATION_PERIODS##", str(int(alert["properties"]["failingPeriods"]["numberOfEvaluationPeriods"])))
            bicep_template = bicep_template.replace("##FAILING_PERIODS_NUMBER_OF_EVALUATION_PERIODS##", str(int(alert["properties"]["failingPeriods"]["numberOfEvaluationPeriods"])))
          else:
            arm_template = arm_template.replace("##FAILING_PERIODS_NUMBER_OF_EVALUATION_PERIODS##", "")
            bicep_template = bicep_template.replace("##FAILING_PERIODS_NUMBER_OF_EVALUATION_PERIODS##", "")

          if 'failingPeriods' in alert["properties"] and alert["properties"]["failingPeriods"]["numberOfEvaluationPeriods"]:
            arm_template = arm_template.replace("##FAILING_PERIODS_MIN_FAILING_PERIODS_TO_ALERT##", str(int(alert["properties"]["failingPeriods"]["minFailingPeriodsToAlert"])))
            bicep_template = bicep_template.replace("##FAILING_PERIODS_MIN_FAILING_PERIODS_TO_ALERT##", str(int(alert["properties"]["failingPeriods"]["minFailingPeriodsToAlert"])))
          else:
            arm_template = arm_template.replace("##FAILING_PERIODS_MIN_FAILING_PERIODS_TO_ALERT##", "")
            bicep_template = bicep_template.replace("##FAILING_PERIODS_MIN_FAILING_PERIODS_TO_ALERT##", "")

          if 'threshold' in alert["properties"] and alert["properties"]["threshold"]:
            arm_template = arm_template.replace("##THRESHOLD##", str(int(alert["properties"]["threshold"])))
            bicep_template = bicep_template.replace("##THRESHOLD##", str(int(alert["properties"]["threshold"])))
          else:
            arm_template = arm_template.replace("##THRESHOLD##", "")
            bicep_template = bicep_template.replace("##THRESHOLD##", "")

          if 'timeAggregation' in alert["properties"] and alert["properties"]["timeAggregation"]:
            arm_template = arm_template.replace("##TIME_AGGREGATION##", alert["properties"]["timeAggregation"])
            bicep_template = bicep_template.replace("##TIME_AGGREGATION##", alert["properties"]["timeAggregation"])
          else:
            arm_template = arm_template.replace("##TIME_AGGREGATION##", "")
            bicep_template = bicep_template.replace("##TIME_AGGREGATION##", "")

          if 'windowSize' in alert["properties"] and alert["properties"]["windowSize"]:
            arm_template = arm_template.replace("##WINDOW_SIZE##", alert["properties"]["windowSize"])
            bicep_template = bicep_template.replace("##WINDOW_SIZE##", alert["properties"]["windowSize"])
          else:
            arm_template = arm_template.replace("##WINDOW_SIZE##", "")
            bicep_template = bicep_template.replace("##WINDOW_SIZE##", "")

          if 'evaluationFrequency' in alert["properties"] and alert["properties"]["evaluationFrequency"]:
            arm_template = arm_template.replace("##EVALUATION_FREQUENCY##", alert["properties"]["evaluationFrequency"])
            bicep_template = bicep_template.replace("##EVALUATION_FREQUENCY##", alert["properties"]["evaluationFrequency"])
          else:
            arm_template = arm_template.replace("##EVALUATION_FREQUENCY##", "")
            bicep_template = bicep_template.replace("##EVALUATION_FREQUENCY##", "")

          if 'metricName' in alert["properties"] and alert["properties"]["metricName"]:
            arm_template = arm_template.replace("##METRIC_NAME##", alert["properties"]["metricName"])
            bicep_template = bicep_template.replace("##METRIC_NAME##", alert["properties"]["metricName"])
          else:
            arm_template = arm_template.replace("##METRIC_NAME##", "")
            bicep_template = bicep_template.replace("##METRIC_NAME##", "")

          if 'dimensions' in alert["properties"] and "dimensions" in alert["properties"]:
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
            arm_template = arm_template.replace("##DIMENSIONS##", "")
            bicep_template = bicep_template.replace("##DIMENSIONS##", "")

          if 'operationName' in alert["properties"] and alert["properties"]["operationName"]:
            arm_template = arm_template.replace("##OPERATION_NAME##", alert["properties"]["operationName"])
            bicep_template = bicep_template.replace("##OPERATION_NAME##", alert["properties"]["operationName"])
          else:
            arm_template = arm_template.replace("##OPERATION_NAME##", "")
            bicep_template = bicep_template.replace("##OPERATION_NAME##", "")

          if 'status' in alert["properties"] and alert["properties"]["status"]:
            arm_template = arm_template.replace("##STATUS##", json.dumps(alert["properties"]["status"]))

            statuses = []
            for status in alert["properties"]["status"]:
                statuses.append(f"'{status}'")

            bicep_template = bicep_template.replace("##STATUS##", f"[{",".join(statuses)}]")
          else:
            arm_template = arm_template.replace("##STATUS##", "")
            bicep_template = bicep_template.replace("##STATUS##", "")

          if 'causes' in alert["properties"] and alert["properties"]["causes"]:

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

          if 'currentHealthStatus' in alert["properties"] and alert["properties"]["currentHealthStatus"]:
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

          if 'incidentType' in alert["properties"] and alert["properties"]["incidentType"]:
            arm_template = arm_template.replace("##INCIDENT_TYPE##", alert["properties"]["incidentType"])
            bicep_template = bicep_template.replace("##INCIDENT_TYPE##", alert["properties"]["incidentType"])
          else:
            arm_template = arm_template.replace("##INCIDENT_TYPE##", "")
            bicep_template = bicep_template.replace("##INCIDENT_TYPE##", "")

          # Save the ARM template
          with open(os.path.join(args.output, formatted_timestamp, category, resourceType, alert['guid'] + '.json'), 'w') as f:
            f.write(arm_template)

          # Save the Bicep template
          with open(os.path.join(args.output, formatted_timestamp, category, resourceType, alert['guid'] + '.bicep'), 'w') as f:
            f.write(bicep_template)

if __name__ == '__main__':
  main()
