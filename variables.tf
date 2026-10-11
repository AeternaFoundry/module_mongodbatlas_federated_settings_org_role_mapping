variable "federated_settings_org_role_mappings" {
  description = <<EOT
Map of federated_settings_org_role_mappings, attributes below
Required:
    - external_group_name
    - federation_settings_id
    - org_id
    - role_assignments (block):
        - group_id (optional)
        - org_id (optional)
        - roles (optional)
EOT

  type = map(object({
    external_group_name    = string
    federation_settings_id = string
    org_id                 = string
    role_assignments = list(object({
      group_id = optional(string)
      org_id   = optional(string)
      roles    = optional(set(string))
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.federated_settings_org_role_mappings : (
        length(v.role_assignments) >= 1
      )
    ])
    error_message = "Each role_assignments list must contain at least 1 items"
  }
}

