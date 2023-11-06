# Overview

A module for enforcing Cloudflare configuration states with Terraform IaC.

### Cloudflare Healthchecks Configurations
```hcl
module "healthchecks" {
  source     = "github.com/cyberviking949/cloudflare-modules//healthchecks?ref=v1.0.0"
  domain     = "gravitas-sec.com"
  depends_on = [module.dns_zones]
  healthchecks = {
    "thingy" ={
      description    = "thingy healthcheck"
      address       = "thingy"
      path          = "/api/v2/app/version"
      expected_body = "v4.6.0"
    }
    "thingy2" ={
      description    = "thingy2 healthcheck"
      address       = "thingy2"
    }
  }
}
```


## Assigning access to applications
1. healthcheck creation

## TODO
* N/A