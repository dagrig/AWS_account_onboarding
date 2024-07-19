variable "ou_name" {
  description = "Name of the Organizational Unit to be created"
  type        = string
}

variable "permission_set_name" {
  description = "Name of the admin permission set"
  type        = string
}

variable "group_name" {
  description = "Name of the admin group in Identity Store"
  type        = string
}

variable "create_organization" {
  description = "Whether to create a new organization"
  type        = bool
  default     = false
}