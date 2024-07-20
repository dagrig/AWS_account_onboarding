# This module creates a new AWS account in the organization and sets up the necessary resources for onboarding.
resource "aws_organizations_account" "this" {
  name      = var.account_name
  email     = "admin+${var.account_name}@example2.com" # This email address must be unique
  parent_id = var.parent_id
  role_name = "OrganizationAccountAccessRole"
}

# Introducing a delay to allow the account to activate
resource "null_resource" "wait_for_activation" {
  provisioner "local-exec" {
    command = "sleep 120"  # wait for 2 minutes
  }
  depends_on = [aws_organizations_account.this]
}

# Create a new provider for the new account
provider "aws" {
  alias   = "new_account"
  region  = var.aws_region
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.this.id}:role/OrganizationAccountAccessRole" # Assume the role created in the new account
  }
}

# Create a Route53 zone and records in the new account
module "route53" {
  source      = "../route53"
  domain      = var.domain
  dns_records = var.dns_records
  providers = {
    aws = aws.new_account # Use the new account provider 
  }
  depends_on = [null_resource.wait_for_activation] # Wait for the account to activate before creating Route53 records
}