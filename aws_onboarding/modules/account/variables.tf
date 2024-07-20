variable "parent_id" {
  description = "The ID of the parent organizational unit"
  type        = string
}

variable "account_name" {
  description = "The name of the new AWS account"
  type        = string
}

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
    records = list(string)
  }))
}