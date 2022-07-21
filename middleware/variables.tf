variable "project" {
  type = string
}

variable "appsync_api_id" {
  type = string
}

variable "appsync_field" {
  type = string
}

variable "env_vars" {
  type = map(string)
}

variable "appsync_iam_role_arn" {
  type = string
}

variable "lambda_iam_role_arn" {
  type = string
}

variable "vpc_security_group_ids" {
  type = set(string)
}

variable "subnet_ids" {
  type = set(string)
}

variable "log_retention_days" {
  type = number
}

locals {
  name = "${var.project}${title(var.appsync_field)}"
}
