variable "account_name" {
  description = "Name of the AWS account to be created"
  type        = string
}

variable "account_email" {
  description = "Email address associated with the new AWS account"
  type        = string
  default     = "new-unique-email@example.com"
}

variable "parent_ou_id" {
  description = "ID of the parent Organizational Unit"
  type        = string
}

variable "domain" {
  description = "Domain name for the Route53 zone in the new account"
  type        = string
  default     = "mycompany.internal"
}

variable "dns_records" {
  description = "List of DNS records to be created in the new account's Route53 zone"
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))
  default = []
}