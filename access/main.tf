data "cloudflare_zones" "zones" {
  filter {
    name = var.domain
  }
}

resource "cloudflare_access_group" "group" {
  for_each = { for group in var.group : group.name => group }
  zone_id  = data.cloudflare_zones.zones.zones[0].id
  name     = each.value.name
  dynamic "include" {
    for_each = try(each.value.include, null) != null ? [each.value] : []
    content {
      login_method = try(each.value.include["login_method"], null)
    }
  }
  lifecycle {
    ignore_changes = [id]
  }
}

resource "cloudflare_access_application" "access_app" {
  for_each   = { for app in var.application : app.name => app }
  zone_id    = data.cloudflare_zones.zones.zones[0].id
  domain     = "${each.key}.${var.domain}"
  name       = each.key
  depends_on = [cloudflare_access_group.group]
}

resource "cloudflare_healthcheck" "app_healthchecks" {
  for_each            = local.apps_with_hc
  zone_id             = data.cloudflare_zones.zones.zones[0].id
  name                = "${each.key}.${var.domain}_Healthcheck"
  address             = cloudflare_access_application.access_app[each.key].domain
  path                = each.value.hc_path
  type                = "HTTPS"
  port                = 443
  method              = "GET"
  expected_body       = each.value.hc_body != null ? each.value.hc_body : "alive"
  expected_codes      = each.value.hc_codes != null ? each.value.hc_codes : ["200"]
  follow_redirects    = true
  allow_insecure      = false
  timeout             = 10
  retries             = 3
  interval            = 60
  consecutive_fails   = 3
  consecutive_successes = 2
  depends_on          = [cloudflare_access_application.access_app]
}



resource "cloudflare_access_policy" "app_policy" {
  for_each       = { for app in var.application : app.name => app }
  zone_id        = data.cloudflare_zones.zones.zones[0].id
  application_id = cloudflare_access_application.access_app[each.key].id
  name           = "${each.key}.${var.domain} Access Policy"
  decision       = (each.value.decision) == null ? "allow" : each.value.action
  precedence     = index(var.application, each.value) + 1
  dynamic "include" {
    for_each = try(each.value, null) != null ? [each.value] : []
    content {
      #login_method      = try(each.value.login_method, null)
      group = [cloudflare_access_group.group[each.value.group].id]
      #everyone          = try(each.value.everyone, null)
    }
  }
  depends_on = [cloudflare_access_application.access_app]
}