variable "account_name" {
  description = "The name of the account"
  type        = string
}

variable "account_email" {
  description = "The email address of the account"
  type        = string
}

variable "parent_id" {
  description = "The ID of the parent organizational unit"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the Route53 hosted zone"
  type        = string
  default     = null
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

variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "is_first_account" {
  description = "Whether this is the first account (account1) with Route53 permissions"
  type        = bool
  default     = false
}

variable "route53_account_id" {
  description = "The ID of the account with Route53 permissions (account1)"
  type        = string
  default     = null
}