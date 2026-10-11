resource "mongodbatlas_federated_settings_org_role_mapping" "federated_settings_org_role_mappings" {
  for_each = var.federated_settings_org_role_mappings

  external_group_name    = each.value.external_group_name
  federation_settings_id = each.value.federation_settings_id
  org_id                 = each.value.org_id

  dynamic "role_assignments" {
    for_each = each.value.role_assignments
    content {
      group_id = role_assignments.value.group_id
      org_id   = role_assignments.value.org_id
      roles    = role_assignments.value.roles
    }
  }
}

