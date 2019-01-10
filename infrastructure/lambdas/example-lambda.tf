
provider "aws" {
  region  = "${var.aws_region}"
}

resource "aws_lambda_function" "example_lambda" {
  filename         = "example-lambda.zip"
  function_name    = "example-lambda-${var.environment}-${var.aws_region}"
  role             = "${var.role_arn}"
  handler          = "example-lambda.handler"
  runtime          = "python3.7"
  source_code_hash = "${base64sha256(file("example-lambda.zip"))}"
  timeout          = 15
  memory_size      = 128
  publish          = true
  reserved_concurrent_executions = "${var.reserved_concurrent_executions}"

  vpc_config {
    security_group_ids = ["${split(",", var.security_groups)}"]
    subnet_ids         = ["${split(",", var.subnets)}"]
  }

  environment {
    variables = {
      environment = "${var.environment}-${var.aws_region}"
    }
  }
}

output "example_lambda_arn" {
  value = "${aws_lambda_function.example_lambda.arn}"
}

output "example_lambda_version" {
  value = "${aws_lambda_function.example_lambda.version}"
}
