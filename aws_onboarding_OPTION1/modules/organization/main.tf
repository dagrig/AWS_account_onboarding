// Org resources
resource "aws_organizations_organization" "org" {
  aws_service_access_principals = ["sso.amazonaws.com"]
  feature_set = "ALL"
}

resource "aws_organizations_organizational_unit" "ou" {
  name      = var.ou_name
  parent_id = aws_organizations_organization.org.root_id
}

// SSO resources
resource "aws_ssoadmin_instance" "instance" {
  identity_store_id = var.identity_store_id
}

resource "aws_ssoadmin_permission_set" "admin_permission_set" {
  instance_arn = aws_ssoadmin_instance.instance.arn
  name         = var.permission_set_name
}

// SSO Admin resources
resource "aws_ssoadmin_managed_policy_attachment" "admin_policy_attachment" {
  instance_arn     = aws_ssoadmin_instance.instance.arn
  permission_set_arn = aws_ssoadmin_permission_set.admin_permission_set.arn
  managed_policy_arn = aws_iam_policy.admin_policy.arn
}

resource "aws_ssoadmin_account_assignment" "admin_assignment" {
  instance_arn     = aws_ssoadmin_instance.instance.arn
  permission_set_arn = aws_ssoadmin_permission_set.admin_permission_set.arn
  principal_type   = "GROUP"
  principal_id     = aws_identitystore_group.admin_group.group_id
  target_id        = aws_organizations_organizational_unit.ou.id
  target_type      = "OU"
}

// Identity Store resources
resource "aws_identitystore_group" "admin_group" {
  identity_store_id = var.identity_store_id
  display_name      = var.group_name
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
