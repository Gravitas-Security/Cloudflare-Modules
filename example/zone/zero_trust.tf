module "zero_trust" {
  source = "github.com/cyberviking949/cloudflare-modules//zero_trust?ref=v2.6.0"

  account_name = "account name"

  gw_policies = [
    {
      name        = "Block bad categories"
      description = "block dns for malicious domains"
      filters     = ["dns"]
      traffic     = "any(dns.content_category[*] in {169 177 124 128 161}) and not(any(dns.domains[*]))"
      rule_settings = {
        block_page_enabled = true
      }
    }
  ]
}
