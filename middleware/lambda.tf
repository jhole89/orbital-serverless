resource "aws_lambda_function" "lambda" {
  function_name    = local.name
  role             = var.lambda_iam_role_arn
  runtime          = "go1.x"
  handler          = "main"
  filename         = data.archive_file.code.output_path
  source_code_hash = filebase64sha256(data.archive_file.code.output_path)
  timeout          = 900
  memory_size      = 1024

  vpc_config {
    security_group_ids = var.vpc_security_group_ids
    subnet_ids         = var.subnet_ids
  }

  environment {
    variables = var.env_vars
  }
}

data "archive_file" "code" {
  source_file = "${path.module}/../lambdas/${var.appsync_field}/main"
  output_path = "${path.module}/../lambdas/${var.appsync_field}/main.zip"
  type        = "zip"
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = var.log_retention_days
}
