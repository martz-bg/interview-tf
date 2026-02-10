provider "tfe" {
  token = var.tfe_token
}
resource "tfe_organization" "interview-org" {
  name  = var.organization
  email = var.email
}

resource "tfe_project" "interview-project" {
  organization = tfe_organization.interview-org.name
  name = "Interview Project"
}

resource "tfe_oauth_client" "vcs-repo" {
  organization     = var.organization
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_token
  service_provider = "github"
}

resource "tfe_workspace" "vcs-repo-parent" {
  name                 = "parent-ws"
  organization         = var.organization
  queue_all_runs       = false
  vcs_repo {
    branch             = "main"
    identifier         = "martz-bg/interview-tf"
    oauth_token_id     = tfe_oauth_client.vcs-repo.oauth_token_id
  }
}

resource "tfe_workspace" "cli-driven-ws-1" {
  name         = "CLI-Driven Workspace 1"
  organization = var.organization
  project_id   = tfe_project.interview-project.id
}

resource "tfe_workspace" "cli-driven-ws-2" {
  name         = "CLI-Driven Workspace 2"
  organization = var.organization
  project_id   = tfe_project.interview-project.id
}

resource "tfe_workspace" "cli-driven-ws-3" {
  name         = "CLI-Driven Workspace 3"
  organization = var.organization
  project_id   = tfe_project.interview-project.id
}

resource "tfe_variable_set" "varset" {
  name          = "Interview Varset"
  description   = "Some description."
  organization  = var.organization
}

resource "tfe_workspace_variable_set" "ws-varset-1" {
  variable_set_id = tfe_variable_set.varset.id
  workspace_id    = tfe_workspace.cli-driven-ws-1.id
}

resource "tfe_workspace_variable_set" "ws-varset-2" {
  variable_set_id = tfe_variable_set.varset.id
  workspace_id    = tfe_workspace.cli-driven-ws-2.id
}

resource "tfe_workspace_variable_set" "ws-varset-3" {
  variable_set_id = tfe_variable_set.varset.id
  workspace_id    = tfe_workspace.cli-driven-ws-3.id
}

resource "tfe_variable" "tf-var" {
  key             = "interview_tf_var"
  value           = "This is the TF variable"
  category        = "terraform"
  description     = "a useful description of the TF variable"
  variable_set_id = tfe_variable_set.varset.id
}

resource "tfe_variable" "env-var" {
  key             = "interview_env_var"
  value           = "This is the ENV variable"
  category        = "env"
  description     = "a useful description of the environment variable"
  variable_set_id = tfe_variable_set.varset.id
}