resource "aws_organizations_organization" "this" {
  aws_service_access_principals = ["cloudtrail.amazonaws.com"]
  feature_set                   = "ALL"
}

resource "aws_organizations_organizational_unit" "this" {
  name      = "my-ou"
  parent_id = aws_organizations_organization.this.id
}