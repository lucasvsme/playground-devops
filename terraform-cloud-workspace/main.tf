data "tfe_organization" "this" {
  name = var.tfe_organization_name
}

resource "tfe_project" "this" {
  name         = var.tfe_project_name
  organization = data.tfe_organization.this.name
}

resource "tfe_workspace" "this" {
  name         = var.tfe_workspace_name
  project_id   = tfe_project.this.id
  organization = data.tfe_organization.this.name
}
