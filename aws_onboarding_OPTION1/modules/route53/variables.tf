variable "domain" {
  description = "The domain name for the Route 53 zone"
  type        = string
}

variable "dns_records" {
  description = "A list of DNS records to create in the zone"
  type        = list(object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))
}