terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.28.0"
    }
  }
  backend "local" {}
}

provider "aws" {
  region = "eu-west-2"
}