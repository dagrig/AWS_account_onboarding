provider "aws" {
  region = "us-east-1"
}

module "organization" {
  source = "./modules/organization"
  create_organization = false  # Set this to false to bypass creating a new organization
  org_id = "ou-gmba-b7ljmf6d"  # Provide your existing organization ID
}

module "account" {
  source       = "./modules/account"
  parent_id    = module.organization.organizational_unit_id
  account_name = var.account_name
  domain       = var.domain
  dns_records  = var.dns_records
  providers = {
    aws = aws
  }
}