terraform {

  # supported version of Terraform CLI (1.x)
  required_version = "~> 1.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "= 3.26.0"
    }
  }
  cloud {
    organization = "some TFCloud Org"
    hostname     = "app.terraform.io" # Optional; defaults to app.terraform.io

    workspaces {
      tags = ["Cloudflare-IaC-Zone", "source:cli"]
    }
  }
}
