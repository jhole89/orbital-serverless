terraform {
  backend "remote" {
    organization = "Manta-Innovations"
    workspaces {
      prefix = "orbital-"
    }
  }
}

module "orbital" {
  source     = "../"
  account_id = var.account_id
  region     = var.region
}
