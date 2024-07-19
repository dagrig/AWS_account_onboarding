variable "domain" {
  description = "The domain name for the Route53 zone"
  type        = string
}

variable "dns_records" {
  description = "List of DNS records to be created in the zone"
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))
  default = []
}