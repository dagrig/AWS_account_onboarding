# Output the Organization ID
output "organization_id" {
  value = local.organization_id
}

# Output the Organizational Unit ID
output "organizational_unit_id" {
  value = aws_organizations_organizational_unit.ou.id
}

# Output the SSO Instance ARN
output "sso_instance_arn" {
  value = local.sso_instance_arn
}

# Output the Identity Store ID
output "identity_store_id" {
  value = local.sso_identity_store_id
}

# Output the Permission Set ARN
output "permission_set_arn" {
  value = local.sso_instance_arn != null ? aws_ssoadmin_permission_set.admin_permission_set[0].arn : null
}

# Output the Admin Group ID
output "admin_group_id" {
  value = local.sso_identity_store_id != null ? aws_identitystore_group.admin_group[0].group_id : null
}