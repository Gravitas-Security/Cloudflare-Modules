resource "cloudflare_ruleset" "custom_rulesets" {
  zone_id   = var.zone_id
  name      = "custom default rulesets"
  description = "custom default rulesets"
  kind    = "zone"
  phase      = "http_request_firewall_custom"
  rules {
    description = "block bad IP's"
    expression = "(ip.src in $blacklist)"
    action = "block"
    enabled = true
    }
  rules {
    description = "block bots"
    expression = "cf.client.bot"
    action = "block"
    enabled = true
    }
  for_each = local.rules
  rules {
    description = each.value.description  
    expression = each.value.expression
    action = (each.value.action) == null ? "block" : each.value.action
    enabled = true
    logging {
      enabled = (each.value.logging) == null ? "false" : each.value.action
    }
    action_parameters {
      products = try(each.value.skipped_products, null)
      phases   = try(each.value.skipped_phases, null)
    }
  }
  lifecycle {
      ignore_changes = [
        zone_id
    ]
  }
}

# resource "cloudflare_ruleset" "custom_rulesets" {
#   for_each = local.rules

#   zone_id   = var.zone_id
#   name      = each.value.name
#   description = each.value.description  
#   kind    = "zone"
#   phase      = "http_request_firewall_custom"
#   rules {
#     description = each.value.description  
#     expression = each.value.expression
#     action = (each.value.action) == null ? "block" : each.value.action
#     enabled = true
#     logging {
#       enabled = try(each.value.logging, null)
#     }
#     action_parameters {
#       products = try(each.value.skipped_products, null)
#       phases   = try(each.value.skipped_phases, null)
#     }
#     }
#   lifecycle {
#       ignore_changes = [
#         zone_id
#     ]
#   }
# }
