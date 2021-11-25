resource "aws_lambda_function" "neptune-integration" {
  function_name = "${var.project}NeptuneIntegration-${var.endpoint_name}"
  role          = var.lambda_iam_role_arn
  runtime       = "go1.x"
  handler       = "main"
  filename      = var.lambda_zip
  vpc_config {
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
  }
  environment {
    variables = {
      DB = var.db_endpoint
    }
  }
}
