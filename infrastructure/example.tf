provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-16fd7026"
  instance_type = "t2.micro"
}
