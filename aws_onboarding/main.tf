provider "aws" {
  region = "us-east-1"
}

module "organization" {
  source = "./modules/organization"
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