// Load the YAML content for the alert (Object)
var Alerts = loadYamlContent('../../../services/Storage/storageAccounts/alerts.yaml')
var Alert = Alerts[0]

// DESCRIPTION HEADER AND VERSION <----------------------------- CHANGE VERSION NUMBER HERE
var AlertDescriptionHeader = 'Automated AVD Alert Deployment Solution (v3.0.0)<br>'

// Combine Alert References into Description (May have multiple references or even none)
var AlertReferences = [for ref in Alert.references: '${ref.name} - ${ref.url}']
var AlertReferencesNew = join(AlertReferences, '\n')
var Description = '${AlertDescriptionHeader}${Alert.description}\nResources:\n${AlertReferencesNew}'

//var AlertDescNew = (AMBAalerts[0].references != null) ? '${AlertDescription}\nResources:\n${AlertReferences}' : '${AlertDescription}'

//  var AlertDescNew = [for Alert in AMBAalerts : (Alert.references != null) ? '${Alert.description}\nResources:\n${join(Alert.references, '\n')}' : '${Alert.description}']

// output AlertDescNew string = AlertDescNew
output AlertReferencesNew string = AlertReferencesNew
output Description string = Description



