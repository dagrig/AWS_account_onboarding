variable "ou_name" {
  description = "The name of the organizational unit"
  type        = string
}

variable "identity_store_id" {
  description = "The ID of the AWS SSO identity store"
  type        = string
}

variable "group_name" {
  description = "The name of the identity store group"
  type        = string
}

variable "permission_set_name" {
  description = "The name of the permission set"
  type        = string
}