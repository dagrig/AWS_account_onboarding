# modules/organization/main.tf

# Data source to fetch SSO instances
data "aws_ssoadmin_instances" "sso" {}

# Locals for SSO-related values
locals {
  sso_instance_arn      = length(data.aws_ssoadmin_instances.sso.arns) > 0 ? tolist(data.aws_ssoadmin_instances.sso.arns)[0] : null  # Get the first SSO instance ARN
  sso_identity_store_id = length(data.aws_ssoadmin_instances.sso.identity_store_ids) > 0 ? tolist(data.aws_ssoadmin_instances.sso.identity_store_ids)[0] : null # Get the first SSO identity store ID
}

# Check if organization exists
data "aws_organizations_organization" "existing" {
  count = var.create_organization ? 0 : 1 # If create_organization is true, don't fetch existing organization
}

# Create organization if it doesn't exist
resource "aws_organizations_organization" "new" {
  count = var.create_organization ? 1 : 0
  aws_service_access_principals = [  # List of service principals that can be enabled in the organization
    "sso.amazonaws.com",
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ] # Add more service principals as needed
  feature_set = "ALL" # Enable all features
}

# Use existing or new organization
locals {
  organization_id = var.create_organization ? aws_organizations_organization.new[0].id : data.aws_organizations_organization.existing[0].id
  root_id         = var.create_organization ? aws_organizations_organization.new[0].roots[0].id : data.aws_organizations_organization.existing[0].roots[0].id
  master_account_id = var.create_organization ? aws_organizations_organization.new[0].master_account_id : data.aws_organizations_organization.existing[0].master_account_id
}

# Create an Organizational Unit
resource "aws_organizations_organizational_unit" "ou" {
  name      = var.ou_name
  parent_id = local.root_id
}

# Create an Identity Store Group (if SSO is enabled)
resource "aws_identitystore_group" "admin_group" {
  count             = local.sso_identity_store_id != null ? 1 : 0 # Only create if SSO is enabled
  display_name      = var.group_name
  description       = "Admin group for AWS accounts"
  identity_store_id = local.sso_identity_store_id
}

# Create a Permission Set (if SSO is enabled)
resource "aws_ssoadmin_permission_set" "admin_permission_set" {
  count            = local.sso_instance_arn != null ? 1 : 0 
  name             = var.permission_set_name
  instance_arn     = local.sso_instance_arn
  session_duration = "PT1H"
}

# Attach AdministratorAccess policy to the Permission Set (if SSO is enabled)
resource "aws_ssoadmin_managed_policy_attachment" "admin_policy" {
  count              = local.sso_instance_arn != null ? 1 : 0
  instance_arn       = local.sso_instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.admin_permission_set[0].arn
}

# Create account assignment (if SSO is enabled)
resource "aws_ssoadmin_account_assignment" "admin_assignment" {
  count              = local.sso_instance_arn != null ? 1 : 0 
  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.admin_permission_set[0].arn
  principal_id       = aws_identitystore_group.admin_group[0].group_id
  principal_type     = "GROUP"
  target_id          = local.master_account_id
  target_type        = "AWS_ACCOUNT"
}