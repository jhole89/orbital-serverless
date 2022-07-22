variable "region" {
  description = "Region to provision services within."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to host services in."
  type        = string
}

variable "log_retention_days" {
  description = "Number of days to store logs in Cloudwatch"
  type        = number
  default     = 7
}

variable "kms_deletion_days" {
  description = "Number of days to wait before deleting KMS keys"
  type        = number
  default     = 7
}

locals {
  project_name = "Orbital"
}
