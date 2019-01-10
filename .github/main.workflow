workflow "New workflow" {
  on = "push"
  resolves = ["docker build app prod"]
}

action "docker build app prod" {
  uses = "actions/docker/cli@76ff57a6c3d817840574a98950b0c7bc4e8a13a8"
  runs = "docker build -t balassit/my-angular-project:prod ."
}
