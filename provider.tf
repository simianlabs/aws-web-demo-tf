terraform {
  required_version = ">= 0.11.7"

  backend "s3" {
    bucket = "iot-terraform"
    key    = "demostate"
  }
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.awsRegion}"
}
