output "organization_id" {
  value = var.create_organization ? aws_organizations_organization.this[0].id : var.org_id
}

output "organizational_unit_id" {
  value = aws_organizations_organizational_unit.this.id
}