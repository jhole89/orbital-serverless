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

module "orbital" {
  source                 = "../"
  region                 = var.region
  vpc_id                 = data.aws_vpc.default.id
}
