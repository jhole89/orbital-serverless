resource "aws_vpc_endpoint" "athena" {
  service_name        = "com.amazonaws.${var.region}.athena"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  vpc_id             = var.vpc_id
  subnet_ids         = var.subnet_ids
  security_group_ids = var.vpc_security_group_ids
}

#resource "aws_vpc_endpoint" "sqs" {
#  service_name = "com.amazonaws.${var.region}.sqs"
#  vpc_endpoint_type = "Interface"
#  private_dns_enabled = true
#
#  vpc_id       = var.vpc_id
#  subnet_ids = var.subnet_ids
#  security_group_ids = var.vpc_security_group_ids
#}
