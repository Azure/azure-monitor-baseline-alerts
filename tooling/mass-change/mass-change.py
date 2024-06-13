import yaml
import argparse
import os
import uuid
import json  # Import the json module


# Parse command line arguments
def parseArguments():
  parser = argparse.ArgumentParser(description='This script helps make mass changes to AMBA repo.')
  parser.add_argument('-a', '--amba-dir', type=str, required=False, metavar='file', help='Path to  metric definitions', default="../..")

  args = parser.parse_args()

  return args


# Output the query results to a JSON file
def outputToYamlFile(data, filename):
  # Write the results to a file
  with open(filename, "w+") as f:
      yaml.dump(data, f, indent=2, default_flow_style=False, sort_keys=False)


def main():

  args = parseArguments()

  dir = args.amba_dir

  # Walk the directory structure and find all alerts.yaml files
  for subdir, dirs, files in os.walk(dir):
    for file in files:
      if file != "alerts.yaml":
        continue

      with open(os.path.join(subdir, file), "r+") as f:

        alerts = []
        try:
          alerts = yaml.load(f, Loader=yaml.FullLoader)
        except:
          continue

        resourceType = os.path.basename(subdir)
        resouceCategory = os.path.basename(os.path.dirname(subdir))

        if alerts:
          duplicate_alerts = []
          metric_names = set()
          for alert in alerts:
            # skip if type is not Metric
            if alert.get("type") != "Metric":
              continue

            metric_name = alert["properties"]["metricName"]
            if metric_name in metric_names:
              duplicate_alerts.append(alert)
            else:
              metric_names.add(metric_name)

          if duplicate_alerts:
            for alert in duplicate_alerts:
              # Print the alert category, type, name, and metric name
              print(f"{resouceCategory} {resourceType} {alert.get('name')} {alert.get('properties', {}).get('metricName')}")

      # write yaml file
      #outputToYamlFile(alerts, os.path.join(subdir, file))

if __name__ == "__main__":
  main()
