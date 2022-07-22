resource "aws_appsync_graphql_api" "entity" {
  authentication_type = "AWS_IAM"
  name                = "${local.project_name}EntityApi"
  schema              = file("${path.module}/schemas/entity.graphql")

  log_config {
    cloudwatch_logs_role_arn = aws_iam_role.appsync.arn
    field_log_level          = "ERROR"
  }
}
