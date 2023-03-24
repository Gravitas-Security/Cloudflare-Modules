terraform {

  # supported version of Terraform CLI (1.x)
  required_version = "~> 1.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 3.13.0"
    }
  }
  cloud {
    organization = "some TFCloud Org"
    hostname = "app.terraform.io" # Optional; defaults to app.terraform.io

    workspaces {
      tags = ["Cloudflare-IaC-Account", "source:cli"]
    }
  }
}

provider "cloudflare" {
  # email (or env: CLOUDFLARE_EMAIL)
  # api_key (or env: CLOUDFLARE_API_KEY)
  # api_token (or env: CLOUDFLARE_API_TOKEN) - alternative to "email + api_key"
  # api_user_service_key (or env: CLOUDFLARE_API_USER_SERVICE_KEY) (used in combination w/ api_token, or email + api_key)
}
