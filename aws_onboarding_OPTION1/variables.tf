variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "account_name" {
  description = "The name of the AWS account"
  type        = string
}

variable "account_email" {
  description = "The email address for the AWS account"
  type        = string
}

variable "ou_name" {
  description = "The name of the organizational unit"
  type        = string
}

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


variable "group_name" {
  description = "The name of the identity store group"
  type        = string
}

variable "permission_set_name" {
  description = "The name of the permission set"
  type        = string
}