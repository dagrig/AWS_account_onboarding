# Description: This file is the entry point for the Terraform configuration. It defines the provider and modules to be used.
provider "aws" {
  region = var.aws_region
}

# Module to create an organization
module "organization" {
  source = "./modules/organization"
  create_organization = var.create_organization  # Set this to false to bypass creating a new organization
  org_id = var.org_id  # Provide your existing organization ID
}

# Module to create an account
module "account" {
  source       = "./modules/account"
  parent_id    = module.organization.organizational_unit_id
  account_name = var.account_name
  domain       = var.domain
  dns_records  = var.dns_records
  providers = {
    aws = aws
  }
  aws_region = var.aws_region
}