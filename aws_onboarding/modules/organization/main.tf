resource "aws_organizations_organization" "this" {
  count                         = var.create_organization ? 1 : 0
  aws_service_access_principals = ["cloudtrail.amazonaws.com"]
  feature_set                   = "ALL"
}

data "aws_organizations_organization" "existing" {
  count = var.create_organization ? 0 : 1
}

resource "aws_organizations_organizational_unit" "this" {
  name      = "my-ou1"
  parent_id = var.create_organization ? aws_organizations_organization.this[0].roots[0].id : var.org_id
}