locals {
  opnsense = yamldecode(file("./labfw/lab_data.yaml"))
}

variable "terraform_annotation" {
  description = "Create a terraform category."
  type        = bool
  default     = true
}

variable "manage_alias_category" {
  description = "Add terraform managed category to firewall aliases."
  type        = bool
  default     = false
}

variable "manage_rule_category" {
  description = "Add terraform managed category to firewall aliases."
  type        = bool
  default     = false
}