workflow "New workflow" {
  on = "push"
  resolves = ["build"]
}

action "install" {
  uses = "actions/npm@e7aaefed7c9f2e83d493ff810f17fa5ccd7ed437"
  runs = "npm install"
}

action "build" {
  uses = "actions/npm@e7aaefed7c9f2e83d493ff810f17fa5ccd7ed437"
  runs = "npm run build"
  needs = ["install"]
}
