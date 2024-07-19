variable "domain_name" {
  description = "The domain name for the Route53 hosted zone"
  type        = string
}

variable "dns_records" {
  description = "List of DNS records to create in the hosted zone"
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))
  default = []
}

variable "role_arn" {
  description = "ARN of the role to assume for creating Route53 resources"
  type        = string
}