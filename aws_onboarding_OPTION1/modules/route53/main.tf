// Create a Route53 zone
resource "aws_route53_zone" "main" {
  name = var.domain
}

// Create DNS records in the zone
resource "aws_route53_record" "dns_records" {
  count   = length(var.dns_records)
  zone_id = aws_route53_zone.main.zone_id
  name    = element(var.dns_records, count.index)["name"]
  type    = element(var.dns_records, count.index)["type"]
  ttl     = element(var.dns_records, count.index)["ttl"]
  records = element(var.dns_records, count.index)["records"]
}