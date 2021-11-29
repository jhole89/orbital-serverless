output "appsync_api_id" {
  value = aws_appsync_graphql_api.api.id
}

output "appsync_api_url" {
  value = aws_appsync_graphql_api.api.uris
}

output "datasource_name" {
  value = aws_appsync_datasource.neptune_integration.name
}