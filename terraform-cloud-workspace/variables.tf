variable "tfe_api_token" {
  description = "Terraform Cloud API token created in user settings"
  type        = string
  sensitive   = true
}

variable "tfe_organization_name" {
  description = "Terraform Cloud organization name"
  type        = string
}

variable "tfe_project_name" {
  description = "Terraform Cloud project name"
  type        = string
}

variable "tfe_workspace_name" {
  description = "Terraform Cloud workspace name"
  type        = string
}
