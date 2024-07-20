variable "domain" {
  description = "Domain name for the Route 53 zone"
  type        = string
}

variable "dns_records" {
  description = "List of DNS records to create"
  type        = list(object({
    name  = string
    type  = string
    ttl   = number
    value = list(string)
  }))
}