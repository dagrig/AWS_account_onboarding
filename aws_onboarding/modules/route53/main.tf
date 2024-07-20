# Purpose: Create Route53 zone
resource "aws_route53_zone" "this" {
  provider = aws
  name     = var.domain
}

# Purpose: Create DNS records
resource "aws_route53_record" "dns_records" {
  provider = aws
  for_each = { for record in var.dns_records : record.name => record }

  zone_id = aws_route53_zone.this.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.value
}