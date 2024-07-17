// Create an AWS account
resource "aws_organizations_account" "account" {
  name      = var.account_name
  email     = var.account_email
  parent_id = var.ou_id
  role_name = "OrganizationAccountAccessRole"
}