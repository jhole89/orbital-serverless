##resource "aws_api_gateway_rest_api" "admin" {
##  name = "${local.project_name}Admin"
##}
##
##resource "aws_api_gateway_resource" "admin" {
##  parent_id   = aws_api_gateway_rest_api.admin.root_resource_id
##  rest_api_id = aws_api_gateway_rest_api.admin.id
##  path_part   = "admin"
##}
##
##resource "aws_api_gateway_request_validator" "admin" {
##  name        = "${local.project_name}AdminValidator"
##  rest_api_id = aws_api_gateway_rest_api.admin.id
##  validate_request_body = true
##  validate_request_parameters = true
##}
##
##resource "aws_api_gateway_method" "admin" {
##  rest_api_id   = aws_api_gateway_rest_api.admin.id
##  resource_id   = aws_api_gateway_resource.admin.id
##  http_method   = "POST"
##  authorization = "NONE"
##  api_key_required = false
##
##  request_models       = {
##    "application/json" = aws_api_gateway_model.admin.name
##  }
##  request_parameters = {
##    "method.request.path.proxy"        = false
##  }
##
##  request_validator_id = aws_api_gateway_request_validator.admin.id
##}
##
##resource "aws_api_gateway_model" "admin" {
##  rest_api_id  = aws_api_gateway_rest_api.admin.id
##  name         = "${local.project_name}AdminModel"
##  content_type = "application/json"
##
##  schema = <<EOF
##  {
##    "$schema" : "http://json-schema.org/draft-04/schema#",
##    "title" : "${local.project_name}AdminModel",
##    "type" : "object",
##    "properties" : {
##      "command" : { "type" : "string" }
##    },
##    "required" :["command"]
##  }
##  EOF
##}
##
##resource "aws_api_gateway_integration" "admin" {
##  rest_api_id             = aws_api_gateway_rest_api.admin.id
##  resource_id             = aws_api_gateway_resource.admin.id
##  http_method             = aws_api_gateway_method.admin.http_method
##  type                    = "AWS"
##  integration_http_method = "POST"
##  credentials             = aws_iam_role.api_gw.arn
##  uri                     = "arn:aws:apigateway:${var.region}:sqs:path/${aws_sqs_queue.admin.name}"
##
##  request_parameters = {
##    "integration.request.header.Content-Type" = "'application/x-www-form-urlencoded'"
##  }
##
##  request_templates = {
##    "application/json" = <<EOF
##Action=SendMessage&MessageBody=$input.json('$')
##EOF
##  }
##}
##
##resource "aws_api_gateway_method_response" "http200" {
##  rest_api_id = aws_api_gateway_rest_api.admin.id
##  resource_id = aws_api_gateway_resource.admin.id
##  http_method = aws_api_gateway_method.admin.http_method
##  status_code = 200
##}
##
##resource "aws_api_gateway_integration_response" "http200" {
##  rest_api_id       = aws_api_gateway_rest_api.admin.id
##  resource_id       = aws_api_gateway_resource.admin.id
##  http_method       = aws_api_gateway_method.admin.http_method
##  status_code       = aws_api_gateway_method_response.http200.status_code
##  selection_pattern = "^2[0-9][0-9]"
##
##  depends_on = [
##    aws_api_gateway_integration.admin
##  ]
##}
##
##resource "aws_api_gateway_deployment" "admin" {
##  rest_api_id = aws_api_gateway_rest_api.admin.id
##  depends_on = [
##    aws_api_gateway_integration.admin,
##    aws_api_gateway_account.demo
##  ]
##}
##
##resource "aws_api_gateway_stage" "latest" {
##  deployment_id = aws_api_gateway_deployment.admin.id
##  rest_api_id   = aws_api_gateway_rest_api.admin.id
##  stage_name    = "latest"
##}
##
##resource "aws_api_gateway_usage_plan" "admin" {
##  name = "${local.project_name}AdminUsagePlan"
##
##  api_stages {
##    api_id = aws_api_gateway_rest_api.admin.id
##    stage  = aws_api_gateway_stage.latest.stage_name
##  }
##}
##
##resource "aws_api_gateway_method_settings" "admin" {
##  rest_api_id = aws_api_gateway_rest_api.admin.id
##  stage_name  = aws_api_gateway_stage.latest.stage_name
##  method_path = "*/*"
##
##  settings {
##    metrics_enabled        = true
##    data_trace_enabled = true
##    logging_level          = "INFO"
##
##    throttling_rate_limit  = 100
##    throttling_burst_limit = 50
##  }
##}
##
##resource "aws_api_gateway_account" "demo" {
##  cloudwatch_role_arn = aws_iam_role.api_gw.arn
##}
#
#resource "aws_apigatewayv2_api" "admin" {
#  name          = "${local.project_name}Admin"
#  protocol_type = "WEBSOCKET"
#}
#
#resource "aws_apigatewayv2_route" "admin" {
#  api_id = aws_apigatewayv2_api.admin.id
#
#  route_key = "GET /admin"
#  target    = "integrations/${aws_apigatewayv2_integration.admin.id}"
#}
#
#resource "aws_apigatewayv2_integration" "admin" {
#  api_id = aws_apigatewayv2_api.admin.id
#
#  integration_type    = "AWS_PROXY"
#  integration_uri = aws_lambda_function.admin.invoke_arn
#
#  credentials_arn = aws_iam_role.api_gw.arn
#}
#
#
#resource "aws_apigatewayv2_stage" "admin" {
#  api_id = aws_apigatewayv2_api.admin.id
#
#  name        = "$default"
#  auto_deploy = true
#
#  access_log_settings {
#    destination_arn = aws_cloudwatch_log_group.admin.arn
#
#    format = jsonencode({
#      requestId               = "$context.requestId"
#      sourceIp                = "$context.identity.sourceIp"
#      requestTime             = "$context.requestTime"
#      protocol                = "$context.protocol"
#      httpMethod              = "$context.httpMethod"
#      resourcePath            = "$context.resourcePath"
#      routeKey                = "$context.routeKey"
#      status                  = "$context.status"
#      responseLength          = "$context.responseLength"
#      errorResponseType = "$context.error.responseType"
#      errorMessage = "$content.error.message"
#      integrationErrorMessage = "$context.integrationErrorMessage"
#    })
#  }
#}
#
#resource "aws_cloudwatch_log_group" "admin" {
#  name = "/aws/api_gw/${aws_apigatewayv2_api.admin.name}"
#  retention_in_days = var.log_retention_days
#}
