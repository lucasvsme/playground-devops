packer {
  required_plugins {
    docker = {
      source  = "github.com/hashicorp/docker"
      version = "v1.0.8"
    }
  }
}

source "docker" "container" {
  discard = true
  image   = "alpine:latest"
}

build {
  sources = ["source.docker.container"]

  provisioner "shell" {
    inline = ["ls -l"]
  }
}
