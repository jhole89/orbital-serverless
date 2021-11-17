variable "region" {
  description = "Region to provision services within."
  type        = string
}

variable "account_id" {
  description = "AWS Account ID."
  type        = number
}

locals {
  project_name = "Orbital"
}
