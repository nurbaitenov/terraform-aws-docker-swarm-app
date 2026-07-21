terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}


resource "aws_key_pair" "main" {
  key_name   = "deployer-key"
  public_key = file("/home/nursdev017/.ssh/id_ed25519.pub")
}