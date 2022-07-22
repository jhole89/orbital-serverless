resource "aws_appsync_resolver" "query" {
  api_id      = var.appsync_api_id
  data_source = aws_appsync_datasource.lambda.name
  type        = "Query"
  field       = var.appsync_field
}

resource "aws_appsync_datasource" "lambda" {
  api_id           = var.appsync_api_id
  name             = "${local.name}Api"
  type             = "AWS_LAMBDA"
  service_role_arn = var.appsync_iam_role_arn

  lambda_config {
    function_arn = aws_lambda_function.lambda.arn
  }
}
