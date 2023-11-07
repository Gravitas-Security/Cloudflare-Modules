data "cloudflare_zones" "zones" {
  filter {
    name = var.domain
  }
}

resource "cloudflare_ruleset" "custom_rulesets" {
  zone_id     = data.cloudflare_zones.zones.zones[0].id
  name        = "custom default rulesets"
  description = "custom default rulesets"
  kind        = "zone"
  phase       = "http_request_firewall_custom"
  rules {
    description = "block bad IP's"
    expression  = "(ip.src in $blacklist)"
    action      = "block"
    enabled     = true
  }
  rules {
    description = "allow CF bots"
    expression  = "(ip.geoip.asnum in {13335})"
    action      = "skip"
    enabled     = true
    action_parameters {
      ruleset = "current"
      phases   = ["http_request_firewall_managed"]
    }
    logging {
      enabled = false
    }
  }
  rules {
    description = "block bots"
    expression  = "(cf.client.bot)"
    action      = "block"
    enabled     = true
  }
  dynamic rules {
    for_each = local.rules
    content {
    description = each.value.description
    expression  = each.value.expression
    action      = (each.value.action) == null ? "block" : each.value.action
    enabled     = true
    logging {
      enabled = (each.value.logging) == null ? "false" : each.value.action
    }
    action_parameters {
      products = try(each.value.skipped_products, null)
      phases   = try(each.value.skipped_phases, null)
    }
  }
  }
  lifecycle {
    ignore_changes = [
      zone_id
    ]
  }
}
