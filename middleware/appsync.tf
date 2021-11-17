resource "aws_appsync_graphql_api" "api" {
  authentication_type = "API_KEY"
  name                = "${var.project}${var.endpoint_name}Api"
  schema              = var.schema
}

resource "aws_appsync_datasource" "neptune-integration" {
  api_id           = aws_appsync_graphql_api.api.id
  name             = "${var.project}NeptuneIntegration-${var.endpoint_name}Api"
  type             = "AWS_LAMBDA"
  service_role_arn = var.appsync_iam_role_arn
  lambda_config {
    function_arn = aws_lambda_function.neptune-integration.arn
  }
}
