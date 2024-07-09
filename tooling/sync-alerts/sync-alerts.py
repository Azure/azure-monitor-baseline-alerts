import os
import json


manifests = {}

# Get path to python file
dir_path = os.path.dirname(os.path.realpath(__file__))
print(f"Dir path: {dir_path}")

# find all manifest.json files in the directory and sub directories
for subdir, dirs, files in os.walk(dir_path):
  for file in files:

    # if file is not a manifest file and the parent directory is not prod
    if file != "manifest.json" or os.path.basename(subdir) != "prod":
      continue

    # add manifest to list
    try:
      with open(os.path.join(subdir, file), "r+") as f:
        manifest = json.load(f)
        # check to see if there is a alerts key
        if "alerts" in manifest:
          # just append the alerts key to the list
          manifests[manifest['name']] = manifest["alerts"]
    except:
      print(f"Error reading {subdir}\\{file}")

# print the number of alertRecommendations per key in manifests
for key in manifests:
  print(f"{key}: {len(manifests[key]['alertRuleRecommendations'])}")

# write the results to a file
with open(f"{dir_path}\\manifests.json", "w+") as f:
  json.dump(manifests, f, indent=2, sort_keys=False)

