module "entity_middleware" {
  for_each = toset(["getEntity", "listEntity"])
  source   = "./middleware"

  project        = local.project_name
  appsync_api_id = aws_appsync_graphql_api.entity.id
  appsync_field  = each.value
  env_vars = {
    ORBITAL_DB_ADDRESS = "wss://${aws_neptune_cluster.orbital.reader_endpoint}:${aws_neptune_cluster.orbital.port}"
  }

  appsync_iam_role_arn = aws_iam_role.appsync.arn
  lambda_iam_role_arn  = aws_iam_role.lambda.arn

  vpc_security_group_ids = data.aws_security_groups.default.ids
  subnet_ids             = data.aws_subnets.default.ids
  log_retention_days     = var.log_retention_days
}
