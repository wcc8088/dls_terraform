terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.00"
    }
  }

  required_version = ">= 0.13.1"
}
