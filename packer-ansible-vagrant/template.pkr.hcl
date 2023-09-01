packer {
  required_plugins {
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
  }
}

variable "vagrant_box_name" {
  type = string
}

source "vagrant" "box" {
  provider     = "virtualbox"
  source_path  = "ubuntu/jammy64"
  box_name     = var.vagrant_box_name
  communicator = "ssh"
  add_force    = true
}

build {
  sources = ["source.vagrant.box"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get --yes install software-properties-common",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt-get install --yes ansible"
    ]
  }

  provisioner "ansible-local" {
    playbook_file = "playbook.yml"
  }
}
