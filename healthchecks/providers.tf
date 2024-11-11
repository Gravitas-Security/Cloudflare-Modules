terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "= 4.45.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.23.1"
    }
  }
}