#Output the Route 53 Hosted Zone ID
output "zone_id" {
  description = "The ID of the Route 53 hosted zone."
  value       = aws_route53_zone.main.zone_id
}