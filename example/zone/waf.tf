module "waf_rulesets" {
  source     = "../../../modules/waf_rulesets"
  zone_id    = module.dns_zones.zone_id
  depends_on = [module.dns_zones]

  owasp_waf_settings = {
    action          = "block"
    score_threshold = 40
  }
  cf_waf_action = "block"
  waf_overrides = {
    /*"testing" = {
  urls    = ["test.example.com/no-waf-here"]
  # Disable rule ID 100015.
  rules = {
    "100015": "disable"
  }
  }*/
  }
}

