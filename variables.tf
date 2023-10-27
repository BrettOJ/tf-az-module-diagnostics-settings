
variable "log_analytics_workspace_id" {
  description = "(Required) contains the log analytics workspace ID details for operations diagnostics."
}

variable "diag_object" {
  description = "(Required) Contains the diagnostics setting object."
  type = map(object({
    resource_id = list(string)
    enabled_log = list(tuple([string, bool, number]))
    metric      = list(tuple([string, bool, number]))
  }))
}

variable "resource_type" {
  type        = string
  description = "(Required) Specify the type of azure resource"
}

variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type = object({
    project_code = string
    env          = string
    agency_code  = string
    zone         = string
    tier         = string
  })
}

variable "tags" {
  type        = map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}

variable "dependencies" {
  type        = string
  description = "List of dependecies modules or resources"
  default     = null
}