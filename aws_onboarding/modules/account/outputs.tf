output "account_id" {
  value = aws_organizations_account.account.id
}

output "route53_zone_id" {
  value = var.domain_name
}
