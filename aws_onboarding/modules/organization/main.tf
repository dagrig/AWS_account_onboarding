# Purpose: Create an AWS Organization and Organizational Unit
resource "aws_organizations_organization" "this" {
  count                         = var.create_organization ? 1 : 0 # Only create the organization if the create_organization variable is true
  aws_service_access_principals = ["cloudtrail.amazonaws.com"] # Allow CloudTrail to access the organization
  feature_set                   = "ALL" # Enable all features for the organization
}

data "aws_organizations_organization" "existing" {
  count = var.create_organization ? 0 : 1 # If create_organization is true, then we don't need to fetch the existing organization
}

resource "aws_organizations_organizational_unit" "this" {
  name      = "my-ou"
  parent_id = var.create_organization ? aws_organizations_organization.this[0].roots[0].id : var.org_id # If create_organization is true, then use the new organization ID, otherwise use the provided organization ID
}