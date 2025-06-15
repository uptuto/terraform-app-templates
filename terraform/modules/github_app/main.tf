locals {
  all_envs = concat(["dev", "qa", "prd"], var.additional_envs)
  team_suffixes = ["approver", "writer", "reader"]
}

resource "github_repository" "repo" {
  name        = var.app_name
  visibility  = "public"
  auto_init   = true
}

resource "github_repository_environment" "envs" {
  for_each = toset(local.all_envs)
  repository  = github_repository.repo.name
  environment = each.key
}

resource "github_team" "teams" {
  for_each = {
    for suffix in local.team_suffixes :
    suffix => "${var.app_name}-${suffix}"
  }
  name = each.value
}

resource "github_team_repository" "permissions" {
  for_each = {
    for suffix in local.team_suffixes :
    suffix => {
      team_id    = github_team.teams[suffix].id
      repo_name  = github_repository.repo.name
      permission = suffix == "reader" ? "pull" : "push"
    }
  }
  team_id    = each.value.team_id
  repository = each.value.repo_name
  permission = each.value.permission
}

resource "github_branch_protection_v3" "main" {
  repository = github_repository.repo.name
  branch     = "main"

  required_pull_request_reviews {
    required_approving_review_count = 2
  }

  restrictions {
    teams = [github_team.teams["approver"].slug]
  }
}

