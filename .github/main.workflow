workflow "Docker Deploy" {
  resolves = [
    "Build",
    "Deploy to Docker",
    "Docker Login",
    "filter-to-branch-master"
  ]
  on = "push"
}

action "filter-to-branch-master" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Docker Login" {
  uses = "actions/docker/login@76ff57a6c3d817840574a98950b0c7bc4e8a13a8"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Build" {
  uses = "actions/docker/cli@76ff57a6c3d817840574a98950b0c7bc4e8a13a8"
  runs = "docker build -t balassit/my-angular-project:prod ."
}

action "Deploy to Docker" {
  uses = "actions/docker/cli@76ff57a6c3d817840574a98950b0c7bc4e8a13a8"
  needs = ["Build", "Docker Login", "filter-to-branch-master"]
  runs = "docker push balassit/my-angular-project:prod"
}
