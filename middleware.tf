module "middleware" {
  for_each = toset(["Admin", "Entity"])
  source   = "./middleware"

  project       = local.project_name
  endpoint_name = each.value
  db_endpoint   = aws_neptune_cluster_endpoint.orbital.endpoint
  schema        = file("${path.module}/schemas/${lower(each.value)}.graphql")
  lambda_zip    = filemd5("${path.module}/lambdas/${lower(each.value)}.zip")

  security_group_ids   = var.vpc_security_group_ids
  subnet_ids           = var.subnet_ids
  appsync_iam_role_arn = aws_iam_role.appsync.arn
  lambda_iam_role_arn  = aws_iam_role.lambda.arn
}
