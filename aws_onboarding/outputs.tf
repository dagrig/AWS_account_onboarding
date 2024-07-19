# Output the Organization ID
output "organization_id" {
  value = module.organization.organizational_unit_id
}

# Output the Account ID
output "account_id" {
  value = module.account.account_id
}

# output "route53_zone_id" {
#   value = module.account.route53_zone_id
# }
