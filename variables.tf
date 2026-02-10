variable "tfe_token" {
  description = "Your TF API Token:"
  type        = string
}

variable "organization" {
  description = "Your organization:"
  type        = string
}

variable "email" {
  description = "Your email:"
  type        = string
}

variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}