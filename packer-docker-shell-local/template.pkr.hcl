packer {
  required_plugins {
    docker = {
      source  = "github.com/hashicorp/docker"
      version = "v1.0.8"
    }
  }
}

variable "docker_image_name" {
  type    = string
  default = "com.example/packer-docker-shell-local"
}

variable "docker_image_tag" {
  type    = string
  default = "latest"
}

source "docker" "container" {
  commit = true
  image  = "alpine:latest"
}

build {
  sources = ["source.docker.container"]

  provisioner "shell-local" {
    command = "ls -l"
  }

  post-processor "docker-tag" {
    repository = var.docker_image_name
    tags       = [var.docker_image_tag]
  }
}
