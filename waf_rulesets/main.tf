data "cloudflare_zones" "zones" {
  filter {
    name = var.domain
  }
}

# data "cloudflare_rulesets" "all_rulesets" {
#   zone_id = data.cloudflare_zones.zones.zones[0].id
#   include_rules = true
# }

data "cloudflare_rulesets" "owasp_rulesets" {
  zone_id = data.cloudflare_zones.zones.zones[0].id
  filter {
    name = "Cloudflare OWASP Core Ruleset"
  }
  include_rules = true
}

data "cloudflare_rulesets" "cf_managed_rulesets" {
  zone_id = data.cloudflare_zones.zones.zones[0].id
  filter {
    name = "Cloudflare Managed Ruleset"
  }
  include_rules = true
}

resource "cloudflare_ruleset" "cf_managed_ruleset" {
  name    = "Cloudflare Managed Ruleset"
  zone_id = data.cloudflare_zones.zones.zones[0].id
  kind    = "zone"
  phase   = "http_request_firewall_managed"
  rules {
    description = "Cf Managed Rules"
    action      = "execute"
    expression  = "true"
    enabled     = true
    action_parameters {
      id = "efb7b8c949ac4650a09736fc376e9aee"
      overrides {
        action  = var.cf_waf_action == null ? "block" : var.cf_waf_action
        enabled = true
      }
    }
  }
  rules {
    description = "CF OWASP managed rules"
    action      = "execute"
    expression  = "true"
    enabled     = true
    action_parameters {
      id = "4814384a9e5d4991b9815dcfc25d2f1f"
      overrides {
        rules {
          id              = "6179ae15870a4bb7b2d480d4843b323c"
          action          = var.owasp_waf_settings["action"] == null ? "block" : var.owasp_waf_settings["action"]
          score_threshold = var.owasp_waf_settings["score_threshold"] == null ? 40 : var.owasp_waf_settings["score_threshold"]
        }
        enabled = true
      }
    }
  }
  rules {
    description = "CF Exposed Credentials Check Ruleset"
    action      = "execute"
    expression  = "true"
    enabled     = true
    action_parameters {
      id = "c2e184081120413c86c3ab7e14069605"
      overrides {
        action  = "log"
        enabled = true
      }
    }
  }
  dynamic "rules" {
    for_each = var.owasp_rule_overrides
    content {
      action = rules.value.action == null ? "skip" : rules.value.action
      action_parameters {
        rules = { "4814384a9e5d4991b9815dcfc25d2f1f" = join(",", [for id in rules.value.rules : local.cloudflare_owasp_ruleset[id]])}
      }
      description = rules.value.description
      expression = rules.value.expression
      logging {
      enabled = false
    }
    }
  }
  dynamic "rules" {
    for_each = var.cf_rule_overrides
    content {
      action = rules.value.action == null ? "skip" : rules.value.action
      action_parameters {
        rules = { "efb7b8c949ac4650a09736fc376e9aee" = join(",", [for id in rules.value.rules : local.cf_managed_ruleset[id]])}
      }
      description = rules.value.description
      expression = rules.value.expression
      logging {
      enabled = false
    }
    }
  }
  lifecycle {
    ignore_changes = [
      zone_id
    ]
  }
}