resource "cloudflare_access_group" "group" {
  for_each = { for group in var.group : group.name => group }
  zone_id  = var.zone_id
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
  zone_id    = var.zone_id
  domain     = "${each.key}.${var.domain}"
  name       = each.key
  depends_on = [cloudflare_access_group.group]
}

resource "cloudflare_access_policy" "app_policy" {
  for_each       = { for app in var.application : app.name => app }
  zone_id        = var.zone_id
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