variable "account_name" {
  description = "The name of the AWS account"
  type        = string
}

variable "account_email" {
  description = "The email address for the AWS account"
  type        = string
}

variable "ou_id" {
  description = "The ID of the organizational unit where the account will be created"
  type        = string
}

variable "domain" {
  description = "The domain name for the Route 53 zone"
  type        = string
}