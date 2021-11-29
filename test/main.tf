provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Terraform = "true",
      Service   = "Orbital"
    }
  }
}


data "aws_vpc" "default" {
  default = true
}

data "aws_security_groups" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

module "orbital" {
  source                 = "../"
  account_id             = var.account_id
  region                 = var.region
  vpc_security_group_ids = data.aws_security_groups.default.ids
  subnet_ids             = data.aws_subnet_ids.default.ids
}
