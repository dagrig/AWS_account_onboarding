output "account_id" {
  description = "The ID of the created AWS account."
  value       = aws_organizations_account.account.id
}