variable "region" {
  description = "Region to provision services within."
  type        = string
}

variable "account_id" {
  description = "AWS Account ID."
  type        = number
}

variable "vpc_id" {
  description = "VPC ID to host services in."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "VPC SG IDs to launch services in."
  type        = set(string)
}

variable "subnet_ids" {
  description = "Subnet IDs to launch services in."
  type        = set(string)
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
