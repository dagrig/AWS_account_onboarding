# This file creates an AWS account and then calls the route53 module to create the DNS records for the account.
resource "aws_organizations_account" "account" {
  name      = var.account_name
  email     = var.account_email
  parent_id = var.parent_ou_id
  close_on_deletion = true # Close the account when it's deleted
  iam_user_access_to_billing = "ALLOW" # Allow IAM users to access billing information
}

module "route53" {
  source      = "../route53"
  domain      = var.domain
  dns_records = var.dns_records
}
