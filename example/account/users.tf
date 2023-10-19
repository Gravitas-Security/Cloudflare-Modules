module "account_users" {
  source = "github.com/cyberviking949/cloudflare-modules//account_members?ref=v2.2.0"
  members = {
    ////////////////////// Security Team ///////////////////////////////
    "securityperson@example.com" = {
      roles = ["super_admin", "admin"] //<< Role name MUST match role name in avail_roles.json, or from the console
    }
  }
}