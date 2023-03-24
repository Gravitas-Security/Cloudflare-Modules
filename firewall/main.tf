resource "cloudflare_filter" "non_us" {
  zone_id    = var.zone_id
   description = "block non-US"
   expression = "ip.geoip.country ne \"US\""
   lifecycle {
      ignore_changes = [
       zone_id
    ]
  }
}

resource "cloudflare_firewall_rule" "non_us_rule" {
  description   = "block non-us"
  filter_id = cloudflare_filter.non_us.id
  action    = "block"
 priority = 1
  zone_id     = var.zone_id
  lifecycle {
      ignore_changes = [
        zone_id
    ]
  }
}

resource "cloudflare_filter" "block_bots" {
   zone_id    = var.zone_id
   description = "block bots"
   expression = "cf.client.bot"
   lifecycle {
      ignore_changes = [
       zone_id
   ]
 }
}

resource "cloudflare_firewall_rule" "block_bots_rule" {
  description   = "block bots"
  filter_id = cloudflare_filter.block_bots.id
  action    = "block"
  priority = 2
  zone_id     = var.zone_id
  lifecycle {
      ignore_changes = [
        zone_id
      ]
}
}

resource "cloudflare_filter" "filters" {
  for_each = local.rules

  zone_id = var.zone_id

  description = each.value.description
  expression  = each.value.expression
  paused      = each.value.paused
  lifecycle {
      ignore_changes = [
        zone_id
    ]
  }
}

resource "cloudflare_firewall_rule" "rules" {
  for_each = local.rules

  zone_id   = var.zone_id
  filter_id = cloudflare_filter.filters[each.value.expression].id

  priority    = each.value.priority
  description = each.value.description
  paused      = each.value.paused
  action      = each.value.action
  products    = each.value.products
  lifecycle {
      ignore_changes = [
        zone_id
    ]
  }
}
