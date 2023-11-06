module "zero_trust" {
  source = "github.com/cyberviking949/cloudflare-modules//zero_trust?ref=v1.0.0"

  account_name = "account name"

  gw_policies = {
    "dns_filter" = {
      name        = "Block bad categories"
      description = "block dns for malicious domains"
      precedence  = 2
      action      = "block"
      enabled     = true
      filters     = ["dns"]
      traffic     = "any(dns.content_category[*] in {169 177 124 128 161}) and not(any(dns.domains[*] in $<outputID from domain_allow.tf>))"
      rule_settings = {
        block_page_enabled = true
      }
    }
  }
}
