# Provider block to define the AWS provider and the region to use
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.58"
    }
  }
}

# Define the AWS provider and the region to use
provider "aws" {
  region = var.aws_region
}

# Create the organization, and then call the account module to create the AWS account
module "organization" {
  source               = "./modules/organization"
  ou_name              = var.ou_name
  permission_set_name  = var.admin_permission_set_name
  group_name           = var.admin_group_name
  create_organization  = true  # Set this to false if you're sure an organization already exists
}

# Create the root AWS account, and then call the route53 module to create the DNS records for the account
module "account1" {
  source       = "./modules/account"
  account_name = var.account_name
  account_email = var.account_email
  parent_id = module.organization.organizational_unit_id
  aws_region   = var.aws_region
  domain_name  = var.domain_name
  dns_records  = var.dns_records
}


# # Create account2
# module "account2" {
#   source            = "./modules/account"
#   account_name              = "account2"
#   account_email             = "account2@example.com"
#   parent_id         = module.organization.organizational_unit_id
#   domain_name  = var.domain_name
#   dns_records  = var.dns_records
#   aws_region        = var.aws_region
# }

#... more accounts as needed ...
