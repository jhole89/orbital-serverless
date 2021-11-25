output "graphql_entity_endpoint" {
  value = module.middleware["Entity"].appsync_api_url
}

output "graphql_admin_endpoint" {
  value = module.middleware["Admin"].appsync_api_url
}
