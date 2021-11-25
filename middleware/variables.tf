variable "endpoint_name" {
  type = string
}

variable "project" {
  type = string
}

variable "schema" {
  type = string
}

variable "lambda_iam_role_arn" {
  type = string
}

variable "appsync_iam_role_arn" {
  type = string
}

variable "lambda_zip" {
  type = string
}

variable "db_endpoint" {
  type = string
}

variable "security_group_ids" {
  type = set(string)
}

variable "subnet_ids" {
  type = set(string)
}