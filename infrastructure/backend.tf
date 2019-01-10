terraform {
  backend "s3" {
    bucket = "terraform-us-east-1"
    key    = "example-lambda"
    region = "us-east-1"
  }
}
