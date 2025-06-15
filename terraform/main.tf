module "github_app" {
  source = "./modules/github_app"
  app_name = var.app_name
  additional_envs = var.additional_envs
  prd_protection = var.prd_protection
}
provider "github" {
  token = var.github_token
  owner = "uptuto"  
}

