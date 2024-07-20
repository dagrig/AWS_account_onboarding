variable "create_organization" {
  description = "Controls whether to create a new organization"
  type        = bool
  default     = true
}

variable "org_id" {
  description = "Existing organization ID to use if create_organization is false"
  type        = string
  default     = ""
}