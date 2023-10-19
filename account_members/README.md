# Overview

A module for enforcing Cloudflare configuration states with Terraform IaC.

### Granting access to members and assigning roles
```hcl
module "account_users" {
  source = "github.com/cyberviking949/cloudflare-modules//account_members?ref=v2.2.0"
  members = {
    ////////////////////// Security Team ///////////////////////////////
    "securityperson@example.com" = {
      roles = ["super_admin", "admin"] //<< Role name MUST match role name in avail_roles.md, or from the console
  }
}
}
```


## Assigning access to users
1. Username MUST be in email format
2. Role name MUST match exactly to the available roles in `avail_roles.md`
3. Code will dynamically grab the role_id for the given role name from Cloudflare

## TODO
* N/A