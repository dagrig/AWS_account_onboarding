variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-west-2" 
}

variable "account_name" {
  description = "Name of the AWS account to be created"
  type        = string
}

variable "account_email" {
  description = "Email address associated with the new AWS account"
  type        = string
}

variable "domain_name" {
  description = "Domain name for the Route53 zone"
  type        = string
}

variable "dns_records" {
  description = "List of DNS records to be created"
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))
}

variable "ou_name" {
  description = "Name of the Organizational Unit"
  type        = string
  default     = "my-ou"
}

variable "admin_permission_set_name" {
  description = "Name of the admin permission set"
  type        = string
  default     = "AdminPermissionSet"
}

variable "admin_group_name" {
  description = "Name of the admin group in Identity Store"
  type        = string
  default     = "AdminGroup"
}
