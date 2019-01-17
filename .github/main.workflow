# Build and Deploy App on Push

workflow "Docker Deploy" {
  resolves = [
    "Deploy to Docker",
    "Build",
    "Docker Login"
  ]
  on = "push"
}action "filter-to-branch-master" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Build" {
  uses = "actions/docker/cli@76ff57a6c3d817840574a98950b0c7bc4e8a13a8"
  runs = "docker build -t balassit/my-angular-project:prod ."
}

action "Docker Login" {
  uses = "actions/docker/login@76ff57a6c3d817840574a98950b0c7bc4e8a13a8"
  needs = ["filter-to-branch-master"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Deploy to Docker" {
  uses = "actions/docker/cli@76ff57a6c3d817840574a98950b0c7bc4e8a13a8"
  needs = ["Docker Login", "Build"]
  runs = "docker push balassit/my-angular-project:prod"
}


# Terraform Pull Request

workflow "Terraform" {
  resolves = "terraform-plan"
  on = "pull_request"
}

action "filter-to-pr-open-synced" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
}

action "terraform-fmt" {
  uses = "hashicorp/terraform-github-actions/fmt@v0.1.1"
  needs = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
  env = {
    TF_ACTION_WORKING_DIR = "./infrastructure"
  }
}

action "terraform-init" {
  uses = "hashicorp/terraform-github-actions/init@v0.1.1"
  needs = "terraform-fmt"
  secrets = [
    "GITHUB_TOKEN",
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY",
  ]
  env = {
    TF_ACTION_WORKING_DIR = "./infrastructure"
  }
}

action "terraform-validate" {
  uses = "hashicorp/terraform-github-actions/validate@v0.1.1"
  needs = "terraform-init"
  secrets = ["GITHUB_TOKEN"]
  env = {
    TF_ACTION_WORKING_DIR = "./infrastructure"
  }
}

action "terraform-plan" {
  uses = "hashicorp/terraform-github-actions/plan@v0.1.1"
  needs = "terraform-validate"
  secrets = [
    "GITHUB_TOKEN",
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY",
  ]
  env = {
    TF_ACTION_WORKING_DIR = "./infrastructure"
    # If you're using Terraform workspaces, set this to the workspace name.
    TF_ACTION_WORKSPACE = "default"
  }
}
