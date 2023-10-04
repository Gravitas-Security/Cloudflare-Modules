resource "cloudflare_ruleset" "cf_managed_ruleset" {
  name        = "Cloudflare Managed Ruleset"
  zone_id     = var.zone_id
  kind        = "zone"
  phase       = "http_request_firewall_managed"
  rules { 
    description = "Cf Managed Rules"
    action = "execute"
    expression = "true"
    enabled = true
    action_parameters {
      id = "efb7b8c949ac4650a09736fc376e9aee"
      overrides {
        action = var.cf_waf_action
        enabled = true
      }
      }
    }
  rules { 
    description = "CF OWASP managed rules"
    action = "execute"
    expression = "true"
    enabled = true
    action_parameters {
      id = "4814384a9e5d4991b9815dcfc25d2f1f"
      overrides {
        rules {
          id = "6179ae15870a4bb7b2d480d4843b323c"
          action = var.owasp_waf_settings["action"]
          score_threshold = var.owasp_waf_settings["score_threshold"]
        }
           enabled = true
      }
      }
    }
    rules { 
    description = "CF Exposed Credentials Check Ruleset"
    action = "execute"
    expression = "true"
    enabled = true
    action_parameters {
      id = "c2e184081120413c86c3ab7e14069605"
      overrides {
          action = "log"
          enabled = true
      }
      }
    }
     lifecycle {
      ignore_changes = [
        zone_id
    ]
  }
}