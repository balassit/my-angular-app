# Build and Deploy App on Push

workflow "Docker Deploy" {
  resolves = [
    "Build",
    "filter-on-actor",
  ]
  on = "push"
}

action "filter-on-actor" {
  uses = "balassit/bin/filter@master"
  args = "actor octocat|torvalds"
}

action "Build" {
  uses = "actions/docker/cli@76ff57a6c3d817840574a98950b0c7bc4e8a13a8"
  needs = ["filter-on-actor"]
  runs = "docker build -t balassit/my-angular-project:prod ."
}
