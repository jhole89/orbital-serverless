module "middleware" {
  for_each = toset(["Admin", "Entity"])
  source   = "./middleware"

  project              = local.project_name
  endpoint_name        = each.value
  schema               = file("${path.module}/schemas/${lower(each.value)}.graphql")
  image = aws_ecr_repository.api.repository_url
  appsync_iam_role_arn = aws_iam_role.appsync.arn
  lambda_iam_role_arn  = aws_iam_role.lambda.arn
}

resource "aws_ecr_repository" "api" {
  name = "${lower(local.project_name)}-api"
}

module "docker" {
  source = "./docker"

  host  = aws_ecr_repository.api.repository_url
  image = "ghcr.io/jhole89/${lower(local.project_name)}-app:latest"
}
