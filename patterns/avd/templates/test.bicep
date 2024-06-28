// Load the YAML content for the alert (Object)
var AMBAalertsHostPool = [for alert in (loadYamlContent('../../../services/DesktopVirtualization/hostPools/alerts.yaml')): contains(alert.tags, 'avd') && (alert.visible) ? alert : null]
var AMBAalertsStorage = [for alert in (loadYamlContent('../../../services/Storage/storageAccounts/alerts.yaml')): contains(alert.tags, 'avd') && (alert.visible) ? alert : null]
var AMBAalertsANF = [for alert in (loadYamlContent('../../../services/NetApp/netAppAccounts/alerts.yaml')): contains(alert.tags, 'avd') && (alert.visible) ? alert : null]
var AMBAalertsVM = [for alert in (loadYamlContent('../../../services/Compute/virtualMachines/alerts.yaml')): contains(alert.tags, 'avd') && (alert.visible) ? alert : null]
var AMBAalertsSvcHealth = [for alert in (loadYamlContent('../../../services/Resources/subscriptions/alerts.yaml')): contains(alert.tags, 'avd') && (alert.visible) ? alert : null]


output AVDAlertsHP array = AMBAalertsHostPool
output AVDAlertsStorage array = AMBAalertsStorage
output AVDAlertsANF array = AMBAalertsANF
output AVDAlertsVM array = AMBAalertsVM
output AVDAlertsSvcHealth array = AMBAalertsSvcHealth



