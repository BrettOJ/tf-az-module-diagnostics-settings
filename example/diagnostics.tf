#Example diagnistics.tf file to be deployed alonside a resource module
#This file will create a diagnostic setting for the resource module
#The resource module will need to have a variable called diag_object
#The diag_object variable will need to be a map of objects
#The key of the map will be the name of the diagnostic setting
#The value of the map will be an object with the following properties:
#resource_id - The resource id of the resource to be monitored
#log - A list of lists containing the following values:
#  category - The category of logs to be monitored
#  enabled - A boolean value to enable or disable the log category
#  retention_policy - A list containing the following values:
#    enabled - A boolean value to enable or disable the retention policy
#    days - The number of days to retain the logs
#metric - A list of lists containing the following values:
#  category - The category of metrics to be monitored
#  enabled - A boolean value to enable or disable the metric category
#  retention_policy - A list containing the following values:
#    enabled - A boolean value to enable or disable the retention policy
#    days - The number of days to retain the metrics
#log_analytics_destination_type - The type of log analytics destination to send the logs to
#log_analytics_workspace_id - The id of the log analytics workspace to send the logs to

locals {
  diag_object = {
    "${var.naming_convention_info.name}" = {
      resource_id = [azurerm_kubernetes_cluster.aks_obj.id]
      log         = var.diag_object.log
      metric      = var.diag_object.metric
    }
  }
}

module "diagnostics" {
  source = "git::https://github.com/BrettOJ/tf-module-az-diagnostic-settings?ref=main"

  log_analytics_workspace_id = var.diag_object.log_analytics_workspace_id
  diag_object                = local.diag_object
  naming_convention_info     = var.naming_convention_info
  resource_type              = "aksdiag" # This is the resource type for the naming convention module
  tags                       = var.tags
}