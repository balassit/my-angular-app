//aws
variable "aws_profile" {
  default     = ""
  description = "aws profile to use"
}

variable "aws_region" {
  description = "aws region to deploy to"
}

variable "role_arn" {}
variable "security_groups" {}
variable "subnets" {}

variable "environment" {}
