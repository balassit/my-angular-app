# Build and Deploy App on Push

workflow "Docker Deploy" {
  resolves = [
    "Build"
  ]
  on = "push"
}

action "filter-to-branch-master" {
  uses = "balassit/bin/filter@master"
  needs = ["Build"]
  args = "actor octocat|torvalds"
}

action "Build" {
  uses = "actions/docker/cli@76ff57a6c3d817840574a98950b0c7bc4e8a13a8"
  needs = ["filter-to-branch-master"]
  runs = "docker build -t balassit/my-angular-project:prod ."
}
