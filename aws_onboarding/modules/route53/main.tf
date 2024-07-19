provider "aws" {
  alias = "assumed_role"
  assume_role {
    role_arn = var.role_arn
  }
}

resource "aws_route53_zone" "main" {
  provider = aws.assumed_role
  name     = var.domain_name
}

resource "aws_route53_record" "records" {
  provider = aws.assumed_role
  count    = length(var.dns_records)
  zone_id  = aws_route53_zone.main.zone_id
  name     = var.dns_records[count.index].name
  type     = var.dns_records[count.index].type
  ttl      = var.dns_records[count.index].ttl
  records  = var.dns_records[count.index].records
}