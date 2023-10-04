#resource "cloudflare_filter" "non_us" {
#   zone_id    = var.zone_id
#   description = "block non-US"
#   expression = "ip.geoip.country ne \"US\""
#   lifecycle {
#      ignore_changes = [
#       zone_id
#    ]
#  }
#}

#resource "cloudflare_firewall_rule" "non_us_rule" {
#  description   = "block non-us"
#  filter_id = cloudflare_filter.non_us.id
#  action    = "block"
#  priority = 1
#  zone_id     = var.zone_id
#  lifecycle {
#      ignore_changes = [
#        zone_id
#    ]
#  }
#}

#resource "cloudflare_filter" "block_bots" {
#   zone_id    = var.zone_id
#   description = "block bots"
#   expression = "cf.client.bot"
#   lifecycle {
#      ignore_changes = [
#       zone_id
#   ]
# }
#}

#resource "cloudflare_firewall_rule" "block_bots_rule" {
#  description   = "block bots"
#  filter_id = cloudflare_filter.block_bots.id
#  action    = "block"
#  priority = 2
#  zone_id     = var.zone_id
#  lifecycle {
#      ignore_changes = [
#        zone_id
#}
#}

resource "cloudflare_ruleset" "custom_rulesets" {
  for_each = local.rules

  zone_id   = var.zone_id
  name      = each.value.name
  description = each.value.description  
  kind    = "zone"
  phase      = "http_request_firewall_custom"
  rules {
    description = each.value.description  
    expression = each.value.expression
    action = (each.value.action) == null ? "block" : each.value.action
    enabled = true
    logging {
      enabled = try(each.value.logging, null)
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
