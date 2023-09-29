locals {
  algorithm = "ED25519"
}

resource "tls_private_key" "login_ssh_key" {
  algorithm = local.algorithm
}

resource "local_file" "private_key" {
  content         = tls_private_key.login_ssh_key.private_key_openssh
  filename        = "keys/${lower(local.algorithm)}_${var.key_name}"
  file_permission = "0600"
}

resource "local_file" "public_key" {
  content         = replace(tls_private_key.login_ssh_key.public_key_openssh, "\n", " ${var.key_email}\n")
  filename        = "keys/${lower(local.algorithm)}_${var.key_name}.pub"
  file_permission = "0775"
}
