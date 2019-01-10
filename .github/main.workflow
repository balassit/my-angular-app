workflow "Docker Deploy" {
  resolves = ["Deploy to Docker"]
  on = "push"
}

action "docker build app prod" {
  uses = "actions/docker/cli@76ff57a6c3d817840574a98950b0c7bc4e8a13a8"
  runs = "docker build -t balassit/my-angular-project:prod ."
}

action "filter-to-branch-master" {
  uses = "actions/bin/filter@master"
  needs = ["docker build app prod"]
  args = "action 'opened|synchronize'"
}

action "Docker Login" {
  uses = "actions/docker/login@76ff57a6c3d817840574a98950b0c7bc4e8a13a8"
  needs = ["filter-to-branch-master"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Deploy to Docker" {
  uses = "actions/docker/cli@76ff57a6c3d817840574a98950b0c7bc4e8a13a8"
  needs = ["Docker Login"]
  runs = "docker push balassit/my-angular-project:prod"
}