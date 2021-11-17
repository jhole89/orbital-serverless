resource "aws_appsync_resolver" "list_query" {
  kind        = "UNIT"
  api_id      = module.middleware["Entity"].appsync_api_id
  data_source = module.middleware["Entity"].datasource_name
  type        = "EntityQuery"
  field       = "list"

  request_template  = file("${path.module}/resolvers/entity_list.vtl")
  response_template = file("${path.module}/resolvers/response.vtl")
}

resource "aws_appsync_resolver" "connections_query" {
  kind        = "UNIT"
  api_id      = module.middleware["Entity"].appsync_api_id
  data_source = module.middleware["Entity"].datasource_name
  type        = "EntityQuery"
  field       = "connections"

  request_template  = file("${path.module}/resolvers/entity_connections.vtl")
  response_template = file("${path.module}/resolvers/response.vtl")
}

resource "aws_appsync_resolver" "entity_by_id_query" {
  kind        = "UNIT"
  api_id      = module.middleware["Entity"].appsync_api_id
  data_source = module.middleware["Entity"].datasource_name
  type        = "EntityQuery"
  field       = "entity"

  request_template  = file("${path.module}/resolvers/entity_by_id.vtl")
  response_template = file("${path.module}/resolvers/response.vtl")
}

resource "aws_appsync_resolver" "admin_rebuild_query" {
  kind        = "UNIT"
  api_id      = module.middleware["Admin"].appsync_api_id
  data_source = module.middleware["Admin"].datasource_name
  type        = "AdminQuery"
  field       = "rebuild"

  request_template  = file("${path.module}/resolvers/admin_rebuild.vtl")
  response_template = file("${path.module}/resolvers/response.vtl")
}
