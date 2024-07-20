output "organization_id" {
  value = aws_organizations_organization.this.id
}

output "organizational_unit_id" {
  value = aws_organizations_organizational_unit.this.id
}