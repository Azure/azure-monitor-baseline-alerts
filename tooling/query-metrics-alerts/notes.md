az provider list --query "[].{namespace:namespace,resourceTypes:resourceTypes[].{resourceType:resourceType}}" > .\provider_list.json
