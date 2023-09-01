packer {
  required_plugins {
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "v1.1.0"
    }
    docker = {
      source  = "github.com/hashicorp/docker"
      version = "v1.0.8"
    }
  }
}

variable "docker_image_name" {
  type    = string
  default = "com.example/packer-ansible-docker"
}

variable "docker_image_tag" {
  type    = string
  default = "latest"
}

source "docker" "container" {
  image       = "ubuntu:22.04"
  run_command = [
    "--detach",
    "--interactive", "--tty",
    "--entrypoint=/bin/bash",
    "{{ .Image }}",
  ]
  commit = true
}

build {
  sources = ["source.docker.container"]

  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get install --yes software-properties-common",
      "add-apt-repository --yes --update ppa:ansible/ansible",
      "apt-get install --yes ansible"
    ]
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
  }

  provisioner "ansible-local" {
    playbook_file = "playbook.yml"
  }

  post-processor "docker-tag" {
    repository = var.docker_image_name
    tags       = [var.docker_image_tag]
  }
}
