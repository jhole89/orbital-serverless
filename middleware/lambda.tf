resource "aws_lambda_function" "neptune-integration" {
  function_name = "${var.project}NeptuneIntegration-${var.endpoint_name}"
  role          = var.lambda_iam_role_arn
  runtime       = "go1.x"
  handler = "main"
  filename      = var.lambda_zip
  environment {
    variables = {
      DB = var.db_endpoint
    }
  }
}
