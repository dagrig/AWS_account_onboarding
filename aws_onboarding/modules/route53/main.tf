#Create a Route53 zone and records
resource "aws_route53_zone" "main" {
  name = var.domain
}

resource "aws_route53_record" "records" {
  count   = length(var.dns_records) # Create a record for each item in the list
  zone_id = aws_route53_zone.main.zone_id
  name    = var.dns_records[count.index].name
  type    = var.dns_records[count.index].type
  ttl     = var.dns_records[count.index].ttl
  records = var.dns_records[count.index].records
}
