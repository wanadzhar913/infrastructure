terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.44"
    }
  }
}

provider "aws" {
  region = "ap-southeast-5"
}

resource "aws_instance" "example" {
  ami           = "ami-0367763820bb4f68b" # Ubuntu 20.04 LTS // us-east-1
  instance_type = "t3.micro"
}