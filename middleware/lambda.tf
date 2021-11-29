resource "aws_lambda_function" "neptune_integration" {
  function_name    = "${var.project}NeptuneIntegration${var.endpoint_name}"
  role             = var.lambda_iam_role_arn
  runtime          = "go1.x"
  handler          = "main"
  filename         = var.lambda_zip
  source_code_hash = filebase64sha256(var.lambda_zip)
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

resource "aws_cloudwatch_log_group" "neptune_integration" {
  name              = "/aws/lambda/${aws_lambda_function.neptune_integration.function_name}"
  retention_in_days = var.log_retention_days
}
