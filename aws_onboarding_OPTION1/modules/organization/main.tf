// Org resources


# Data source for AWS Organization
data "aws_organizations_organization" "org" {}

# Data source for AWS Organization
data "aws_organizations_organization" "org_data" {}
resource "aws_organizations_organizational_unit" "ou" {
  name      = var.ou_name
  parent_id = data.aws_organizations_organization.org_data.roots[0].id
}

// SSO resources

# Data source for AWS SSO Instances
data "aws_ssoadmin_instances" "instance" {}


resource "aws_ssoadmin_permission_set" "admin_permission_set" {
  instance_arn = data.aws_ssoadmin_instances.instance.arns[0]
  name         = var.permission_set_name
}

// SSO Admin resources
resource "aws_ssoadmin_managed_policy_attachment" "admin_policy_attachment" {
  instance_arn     = data.aws_ssoadmin_instances.instance.arns[0]
  permission_set_arn = aws_ssoadmin_permission_set.admin_permission_set.arn
  managed_policy_arn = aws_iam_policy.admin_policy.arn
}

# Data source for AWS Identity Store Groups
data "aws_identitystore_group" "admin_group" {
  identity_store_id = data.aws_ssoadmin_instances.instance.identity_store_ids
  filter {
    attribute_path  = "DisplayName"
    attribute_value = "AdminGroup"
  }
}

# Assign permission set to a principal (group)
resource "aws_ssoadmin_account_assignment" "admin_assignment" {
  instance_arn     = data.aws_ssoadmin_instances.instance.arns[0]
  permission_set_arn = aws_ssoadmin_permission_set.admin_permission_set.arn
  principal_type   = "GROUP"
  principal_id     = data.aws_identitystore_group.admin_group.group_id
  target_id        = data.aws_organizations_organization.org.id
  target_type      = "AWS_ACCOUNT"
}


// IAM resources
resource "aws_iam_policy" "admin_policy" {
  name        = "${var.permission_set_name}-policy"
  description = "Admin policy for ${var.permission_set_name}"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action   = "*",
      Effect   = "Allow",
      Resource = "*"
    }]
  })
}
