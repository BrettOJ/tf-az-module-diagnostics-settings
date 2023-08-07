locals {
  diag_object = var.diag_object == null ? {} : var.diag_object
}

module "diagnostic_name" {
  source      = "git::https://github.com/BrettOJ/tf-az-module-naming-convention?ref=main"
  name_format = "res_type|-|project_code|-|env|zone|tier|-|name"
  naming_convention_info = {
    for key, value in local.diag_object : "${key}" => {
      name_info = merge(var.naming_convention_info, {
        name           = key
        instance_count = length(value.resource_id)
      })
      tags = var.tags
    }
  }
  resource_type = var.resource_type
}

