data "aws_caller_identity" "this" {}

data "aws_security_groups" "default" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}


resource "aws_vpc_endpoint" "athena" {
  service_name        = "com.amazonaws.${var.region}.athena"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  vpc_id             = var.vpc_id
  subnet_ids         = data.aws_subnets.default.ids
  security_group_ids = data.aws_security_groups.default.ids
}
