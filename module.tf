
resource "azurerm_monitor_diagnostic_setting" "diagnostics" {
  lifecycle {
    ignore_changes = [log, metric]
  }
  for_each           = var.diag_object == null ? {} : var.diag_object
  name               = module.diagnostic_name.naming_convention_output[each.key].names.0
  target_resource_id = each.value.resource_id[0]
  depends_on         = [var.dependencies]

  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = lookup(each.value, "log_analytics_destination_type", null)


  dynamic "log" {
    for_each = each.value.log == null ? [] : each.value.log
    content {
      category = log.value[0]
      enabled  = log.value[1]
      retention_policy {
        enabled = log.value[2]
        days    = log.value[3]
      }
    }
  }

  dynamic "metric" {
    for_each = each.value.metric == null ? [] : each.value.metric
    content {
      category = metric.value[0]
      enabled  = metric.value[1]
      retention_policy {
        enabled = metric.value[2]
        days    = metric.value[3]
      }
    }
  }
}
