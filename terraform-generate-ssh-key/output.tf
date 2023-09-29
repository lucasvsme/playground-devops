output "public_key" {
  value     = tls_private_key.login_ssh_key.public_key_openssh
  sensitive = true
}

output "private_key" {
  value     = tls_private_key.login_ssh_key.private_key_openssh
  sensitive = true
}
