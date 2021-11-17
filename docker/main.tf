terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.15.0"
    }
  }
}

provider "docker" {
  host = var.host
}

resource "docker_image" "image" {
  name = var.image
}
