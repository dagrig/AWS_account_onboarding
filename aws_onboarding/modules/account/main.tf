resource "aws_organizations_account" "this" {
  name      = var.account_name
  email     = "admin+${var.account_name}@example2.com"
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

provider "aws" {
  alias   = "new_account"
  region  = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.this.id}:role/OrganizationAccountAccessRole"
  }
}

module "route53" {
  source      = "../route53"
  domain      = var.domain
  dns_records = var.dns_records
  providers = {
    aws = aws.new_account
  }
  depends_on = [null_resource.wait_for_activation]
}