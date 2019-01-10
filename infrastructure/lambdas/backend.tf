terraform {
  backend "s3" {
    key     = "example-lambda"
    encrypt = "true"
  }
}
