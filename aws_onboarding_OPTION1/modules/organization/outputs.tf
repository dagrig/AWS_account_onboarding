output "org_id" {
  description = "The ID of the AWS Organization."
  value       = aws_organizations_organization.org.id
}

output "ou_id" {
  description = "The ID of the Organizational Unit."
  value       = aws_organizations_organizational_unit.ou.id
}

# Output the SSO instance ARN
output "instance_arn" {
  value = data.aws_ssoadmin_instances.example.arns[0]
}
