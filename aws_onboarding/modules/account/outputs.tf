# Description: Define the output variables for the account module
output "account_id" {
  value = aws_organizations_account.this.id
}