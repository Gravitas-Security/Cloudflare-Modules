terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "= 4.16.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.23.1"
    }
  }
}