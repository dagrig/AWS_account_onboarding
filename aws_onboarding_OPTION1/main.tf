provider "aws" {
  region = var.aws_region
}

module "organization" {
  source              = "./modules/organization"
  ou_name             = var.ou_name
  group_name          = var.group_name
  permission_set_name = var.permission_set_name
}

module "route53" {
  source      = "./modules/route53"
  domain      = var.domain
  dns_records = var.dns_records
}

module "account" {
  source        = "./modules/account"
  account_name  = var.account_name
  account_email = var.account_email
  ou_id         = module.organization.ou_id
  domain        = var.domain
}