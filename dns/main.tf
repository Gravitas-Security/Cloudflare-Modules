data "cloudflare_accounts" "account" {
  name = var.account_name
}

# Zone creation
resource "cloudflare_zone" "domain" {
  account_id = data.cloudflare_accounts.account.accounts.0.id
  zone       = var.domain
  plan       = var.plan
  type       = var.type
}

# Zone settings
resource "cloudflare_zone_settings_override" "domain_settings" {
  zone_id    = cloudflare_zone.domain.id
  depends_on = [cloudflare_zone.domain]
  settings {
    min_tls_version          = "1.2"
    ssl                      = "strict"
    always_use_https         = "on"
    automatic_https_rewrites = "on"
    cache_level              = "aggressive"
    origin_max_http_version  = 2
    brotli                   = "off"
    true_client_ip_header    = "off"
    security_header {
      enabled = true
    }
  }
}

resource "cloudflare_zone_dnssec" "gravitas_sec_com" {
  zone_id = cloudflare_zone.domain.id
}

# Other A, CNAME, MX, TXT records
resource "cloudflare_record" "records" {
  for_each = var.records
  zone_id  = cloudflare_zone.domain.id
  name     = each.value.name
  priority = try(each.value.priority, null)
  content  = try(each.value.value, null)
  type     = lookup(each.value, "type", null) != null ? lookup(each.value, "type") : "CNAME"
  proxied  = lookup(each.value, "proxied", null) != null ? lookup(each.value, "proxied") : true
  dynamic "data" {
    for_each = try(each.value.data, null) != null ? [each.value] : []
    content {
      algorithm      = try(each.value.data["algorithm"], null)
      altitude       = try(each.value.data["altitude"], null)
      certificate    = try(each.value.data["certificate"], null)
      content        = try(each.value.data["content"], null)
      digest         = try(each.value.data["digest"], null)
      digest_type    = try(each.value.data["digest_type"], null)
      fingerprint    = try(each.value.data["fingerprint"], null)
      flags          = try(each.value.data["flags"], null)
      key_tag        = try(each.value.data["key_tag"], null)
      lat_degrees    = try(each.value.data["lat_degrees"], null)
      lat_direction  = try(each.value.data["lat_direction"], null)
      lat_minutes    = try(each.value.data["lat_minutes"], null)
      lat_seconds    = try(each.value.data["lat_seconds"], null)
      long_degrees   = try(each.value.data["long_degrees"], null)
      long_direction = try(each.value.data["long_direction"], null)
      long_minutes   = try(each.value.data["long_minutes"], null)
      long_seconds   = try(each.value.data["long_seconds"], null)
      matching_type  = try(each.value.data["matching_type"], null)
      name           = try(each.value.data["name"], null)
      order          = try(each.value.data["order"], null)
      port           = try(each.value.data["port"], null)
      precision_horz = try(each.value.data["precision_horz"], null)
      precision_vert = try(each.value.data["precision_vert"], null)
      preference     = try(each.value.data["preference"], null)
      priority       = try(each.value.data["priority"], null)
      proto          = try(each.value.data["proto"], null)
      protocol       = try(each.value.data["protocol"], null)
      public_key     = try(each.value.data["public_key"], null)
      regex          = try(each.value.data["regex"], null)
      replacement    = try(each.value.data["replacement"], null)
      selector       = try(each.value.data["selector"], null)
      service        = try(each.value.data["service"], null)
      size           = try(each.value.data["size"], null)
      tag            = try(each.value.data["tag"], null)
      target         = try(each.value.data["target"], null)
      type           = try(each.value.data["type"], null)
      usage          = try(each.value.data["usage"], null)
      value          = try(each.value.data["value"], null)
      weight         = try(each.value.data["weight"], null)
    }
  }

  depends_on = [
    cloudflare_zone.domain
  ]
}

resource "cloudflare_turnstile_widget" "zone_enable" {
  account_id = data.cloudflare_accounts.account.accounts.0.id
  name           = "${var.domain} - Turnstile"
  bot_fight_mode = false
  domains        = [var.domain]
  mode           = "invisible"
  region         = "world"
}


# resource "cloudflare_certificate_pack" "universal" {
#   count = var.plan == "enterprise" ? 1 : 0
#   zone_id               = cloudflare_zone.domain.id
#   type                  = "advanced"
#   hosts                 = ["${cloudflare_zone.domain.0.zone}", "*.${cloudflare_zone.domain.0.zone}"]
#   validation_method     = "txt"
#   validity_days         = 90
#   certificate_authority = "lets_encrypt"
#   cloudflare_branding   = false
#   depends_on = [
#     cloudflare_zone.domain
#   ]
#   lifecycle {
#     create_before_destroy = true
#   }
# }
