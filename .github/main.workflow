workflow "Deploy App" {
  on = "push"
  resolves = ["Deploy to Docker"]
}

action "docker build app prod" {
  uses = "actions/docker/cli@76ff57a6c3d817840574a98950b0c7bc4e8a13a8"
  runs = "docker build -t balassit/my-angular-project:prod ."
}

# Filter for master branch
action "Master" {
  needs = "Test"
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Docker Login" {
  uses = "actions/docker/login@76ff57a6c3d817840574a98950b0c7bc4e8a13a8"
  needs = ["Master"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Deploy to Docker" {
  uses = "actions/docker/cli@76ff57a6c3d817840574a98950b0c7bc4e8a13a8"
  needs = ["Master", "docker build app prod", "Docker Login"]
  runs = "docker push balassit/my-angular-project:prod"
}
