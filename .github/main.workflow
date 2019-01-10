workflow "Build Angular App" {
  on = "push"
  resolves = ["Deploy to Docker"]
}

# Build application
action "Docker Build App Prod" {
  uses = "actions/docker/cli@76ff57a6c3d817840574a98950b0c7bc4e8a13a8"
  runs = "docker build -t balassit/my-angular-project:prod ."
}

# Filter for master branch
action "master-branch-filter" {
  needs = "Docker Build App Prod"
  uses = "actions/bin/filter@master"
  args = "branch master"
}

# Deploy application
action "Deploy to Docker" {
  uses = "actions/docker/cli@76ff57a6c3d817840574a98950b0c7bc4e8a13a8"
  runs = "docker push balassit/my-angular-project:prod"
  needs = ["Docker Build App Prod"]
}
