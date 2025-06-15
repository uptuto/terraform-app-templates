terraform {
  cloud {
    organization = "uptuto"
    workspaces {
      name = "gh-multi-app"
    }
  }
  required_version = ">= 1.5"
}
