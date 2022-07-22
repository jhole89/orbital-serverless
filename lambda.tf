resource "aws_lambda_function" "admin" {
  function_name    = "${local.project_name}Admin"
  role             = aws_iam_role.lambda.arn
  runtime          = "go1.x"
  handler          = "main"
  filename         = data.archive_file.code.output_path
  source_code_hash = filebase64sha256(data.archive_file.code.output_path)
  timeout          = 900
  memory_size      = 128

  vpc_config {
    security_group_ids = data.aws_security_groups.default.ids
    subnet_ids         = data.aws_subnets.default.ids
  }

  environment {
    variables = {
      ORBITAL_DB_ADDRESS = "wss://${aws_neptune_cluster.orbital.endpoint}:${aws_neptune_cluster.orbital.port}",
      RESULTS_BUCKET     = "s3://${aws_s3_bucket.query_results.bucket}",
    }
  }
}

data "archive_file" "code" {
  source_file = "${path.module}/lambdas/admin/main"
  output_path = "${path.module}/lambdas/admin/main.zip"
  type        = "zip"
}

resource "aws_lambda_function_url" "admin" {
  authorization_type = "NONE"
  function_name      = aws_lambda_function.admin.function_name
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${aws_lambda_function.admin.function_name}"
  retention_in_days = var.log_retention_days
}
