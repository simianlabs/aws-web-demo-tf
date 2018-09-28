terraform {
  required_version = ">= 0.11.7"

  backend "s3" {
    bucket = "iot-terraform"
    key    = "demostate"
  }
}

provider "aws" {
  region = "${var.awsRegion}"
}
