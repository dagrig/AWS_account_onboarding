output "account_id" {
  description = "The ID of the created AWS account."
  value       = module.account.account_id
}

output "zone_id" {
  description = "The ID of the created Route 53 hosted zone."
  value       = module.route53.zone_id
}