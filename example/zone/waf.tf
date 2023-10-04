module "waf_rulesets" {
  source     = "github.com/cyberviking949/cloudflare-modules//waf_rulesets?ref=v1.0.0"
  zone_id    = module.dns_zones.zone_id
  depends_on = [module.dns_zones]

  owasp_waf_settings = {
    action          = "block"
    score_threshold = 40
  }
  cf_waf_action = "block"
}

