# This outputs the organization ID, organizational unit ID, and new account ID.
output "organization_id" {
  value = module.organization.organization_id
}

output "organizational_unit_id" {
  value = module.organization.organizational_unit_id
}

output "new_account_id" {
  value = module.account.account_id
}