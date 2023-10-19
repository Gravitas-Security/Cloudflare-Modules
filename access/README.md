# Overview

A module for enforcing Cloudflare configuration states with Terraform IaC.

### Cloudflare Access Configurations
```hcl
module "access_app" {
  source = "github.com/cyberviking949/cloudflare-modules//access?ref=v2.0.2"
  #source = "C:/Users/steve/cloudflare-modules/access"
  zone_id    = module.dns_zones.zone_id
  domain     = module.dns_zones.domain
  depends_on = [module.dns_zones]


  group = [
    {
      name = "test_group"
      include = {
        login_method = ["fde5709d-c4a5-4a52-b368-dba11118f38b"] //jumpcloud
      }
    }
  ]
  application = [
    {
      name  = "test"
      group = "test_group"
      }
  ]
}
```


## Assigning access to applications
1. Group creation
  - supports mutliple varieties. see provider docs for more https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/access_group#nested-schema-for-include
2. App is the hostname for given domain. e.g. if zone is example.com, app is test for url test.example.com
3. Code will create Application, and policy based off app and group defined
  - app is the url
  - policy includes the requirements of the group
  - default `Allow` and failure will result in block
4. Precedence is set by order of apps. 1st = 1, 2nd = 2, etc 
  - reordering will result in a destroy and reapply of all subsequent rules

## TODO
* N/A