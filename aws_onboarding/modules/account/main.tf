resource "aws_organizations_account" "this" {
  name      = var.account_name
  email     = "admin+${var.account_name}@example.com"
  parent_id = var.parent_id
  role_name = "OrganizationAccountAccessRole"
}

provider "aws" {
  alias   = "new_account"
  profile = aws_organizations_account.this.id
  region  = "us-east-1"
}

module "route53" {
  source      = "../route53"
  domain      = var.domain
  dns_records = var.dns_records
  providers = {
    aws = aws.new_account
  }
}