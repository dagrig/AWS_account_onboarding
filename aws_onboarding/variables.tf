variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
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
    value = list(string)
  }))
}

variable "parent_id" {
  description = "Parent Organizational Unit ID for the new account"
  type        = string
}

variable "create_organization" {
  description = "Controls whether to create a new organization"
  type        = bool
  default     = false
}

variable "org_id" {
  description = "Existing organization ID to use if create_organization is false"
  type        = string
  default     = ""
}