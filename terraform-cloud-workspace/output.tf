output "organization" {
  value = data.tfe_organization.this.name
}

output "workspace" {
  value = tfe_workspace.this.name
}

output "configuration-block" {
  value = <<EOT
cloud {
  organization = "${data.tfe_organization.this.name}"

  workspaces {
    name = "${tfe_workspace.this.name}"
  }
}
EOT
}
