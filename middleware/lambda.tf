resource "aws_lambda_function" "neptune-integration" {
  function_name = "orbital-neptune-integration"
  role          = var.lambda_iam_role_arn
  runtime       = "go1.x"
  package_type  = "Image"
  image_uri     = var.image
}
