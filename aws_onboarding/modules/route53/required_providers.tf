# Purpose: Define the required providers for the route53 module.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.58"
    }
  }
}