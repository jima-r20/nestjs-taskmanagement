terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.11.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
}
