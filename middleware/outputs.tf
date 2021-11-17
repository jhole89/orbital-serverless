output "appsync_api_id" {
  value = aws_appsync_graphql_api.api.id
}

output "datasource_name" {
  value = aws_appsync_datasource.neptune-integration.name
}