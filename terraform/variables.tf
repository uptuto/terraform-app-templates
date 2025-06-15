variable "app_name" { type = string }
variable "additional_envs" { type = list(string) }
variable "prd_protection" { type = bool }
variable "github_token" {
  type        = string
  description = "GitHub Personal Access Token"
  sensitive   = true
}
