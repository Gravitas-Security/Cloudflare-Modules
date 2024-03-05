module "waf_rulesets" {
  source     = "github.com/cyberviking949/cloudflare-modules//waf_rulesets?ref=v2.6.0"
  domain     = "example.com"
  depends_on = [module.dns_zones]
  
  owasp_waf_settings = {
    score_threshold = 45
  }
  owasp_rule_overrides = [
    {
    rules = ["911100: Method is not allowed by policy", "941340: IE XSS Filters - Attack Detected"]
    expression = "(cf.zone.name eq \"example.com\" and http.request.uri.query contains \"skip=rules\")"
    description = "Allow requests with skip=rules in query string"
  }
  ]
  cf_rule_overrides = [
    {
    rules = "vBulletin - SQLi - CVE:CVE-2020-12720-7aeb2faf29284398aeb782e54875e938"
    expression = "(cf.zone.name eq \"example.com\" and http.request.uri.query contains \"skip=rules\")"
    description = "Block requests with empty user-agent"
    }
  ]
  cf_waf_action      = "block"
}

