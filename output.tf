output "diag_object" {
  description = "Output the full object"
  value       = azurerm_monitor_diagnostic_setting.diagnostics
  # value = local.diag_object
}