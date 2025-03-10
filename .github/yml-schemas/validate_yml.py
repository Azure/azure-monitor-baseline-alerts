import yaml
import json
from jsonschema import Draft7Validator, exceptions
import argparse
import os

# Set up argument parser
parser = argparse.ArgumentParser(description='Validate YAML data against JSON schemas.')
parser.add_argument('yaml_files', type=str, help='The YAML files to validate, separated by spaces')

# Parse arguments
args = parser.parse_args()
yaml_files = args.yaml_files.split(' ')
failed_validation = False

class Colors:
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'

# Default schema file names
subschema1_file_name = '.github/yml-schemas/defaultLog.json'
subschema2_file_name = '.github/yml-schemas/defaultStaticMetric.json'
subschema3_file_name = '.github/yml-schemas/defaultAdminActivityLog.json'
subschema4_file_name = '.github/yml-schemas/defaultRHActivityLog.json'
subschema5_file_name = '.github/yml-schemas/defaultSHActivityLog.json'
subschema6_file_name = '.github/yml-schemas/defaultDynamicMetric.json'

# Load the subschemas from files
with open(subschema1_file_name, 'r') as subschema1_file:
    subschema1 = json.load(subschema1_file)

with open(subschema2_file_name, 'r') as subschema2_file:
    subschema2 = json.load(subschema2_file)

with open(subschema3_file_name, 'r') as subschema3_file:
    subschema3 = json.load(subschema3_file)

with open(subschema4_file_name, 'r') as subschema4_file:
    subschema4 = json.load(subschema4_file)

with open(subschema5_file_name, 'r') as subschema5_file:
    subschema5 = json.load(subschema5_file)

with open(subschema6_file_name, 'r') as subschema6_file:
    subschema6 = json.load(subschema6_file)

# Define a mapping of types to schemas
schemas = {
    "log": subschema1,
    "staticthresholdcriterion_metric": subschema2,
    "administrative_activitylog": subschema3,
    "resourcehealth_activitylog": subschema4,
    "servicehealth_activitylog": subschema5,
    "dynamicthresholdcriterion_metric": subschema6
}

for yaml_file_name in yaml_files:
# Load the YAML data from a file
    with open(yaml_file_name, 'r') as yaml_file:
        data = yaml.safe_load(yaml_file)
    print(f"Validating {yaml_file_name}")
    # If the YAML data is a list, continue
    if isinstance(data, list):
    # Validate each entity in the array
      for entity in data:
          entity_type = entity.get("type").lower()
          entity_name = entity.get("name").lower()
          # switch depending on entity_type
          if entity_type == "activitylog":
              # Get Category in properties
              entity_category = entity.get("properties").get("category").lower()
              selector = f"{entity_category}_{entity_type}"
              schema = schemas.get(selector)
          if entity_type == "metric":
              entity_category = entity.get("properties").get("criterionType").lower()
              selector = f"{entity_category}_{entity_type}"
              schema = schemas.get(selector)
          if entity_type == "log":
              schema = schemas.get(entity_type)
          if schema:
              validator = Draft7Validator(schema)
              errors = sorted(validator.iter_errors(entity), key=lambda e: e.path)
              if errors:
                  print(f"{Colors.WARNING}Validation failed for entity: {entity}{Colors.ENDC}")
                  for error in errors:
                      print(f"{Colors.WARNING}Error: {error.message}{Colors.ENDC}")
                      failed_validation = True
              else:
                  print(f"Validation passed for entity: {entity_name}")
          else:
              print(f"{Colors.WARNING}No schema found for entity type: {entity_name}{entity_type}{entity_category}{Colors.ENDC}")
              failed_validation = True
    else:
        print(f"{Colors.WARNING}No alerts configured{Colors.ENDC}")
        # failed_validation = True
if failed_validation:
    print("One or more validations failed.")
    exit(1)



