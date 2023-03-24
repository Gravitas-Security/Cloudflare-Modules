resource "cloudflare_access_group" "group" {
    for_each = var.group
    zone_id    = var.zone_id
    name = each.value.name
    dynamic "include" {
      for_each = try(each.value.include, null) != null ? [each.value] : []
      content {
        login_method      = try(each.value.include["login_method"], null)
    }
  }
  lifecycle {
    ignore_changes = [id]
  }
}

resource "cloudflare_access_application" "access_app"{
  for_each = var.application
  zone_id = var.zone_id
  domain  = each.value.domain
  name = each.value.name
  depends_on = [cloudflare_access_group.group]
}

resource "cloudflare_access_policy" "app_policy" {
    for_each = var.policy
    zone_id    = var.zone_id
    application_id = cloudflare_access_application.access_app[each.value.application].id
    name = each.value.name
    decision = each.value.decision
    precedence =  each.value.precedence
    dynamic "include" {
      for_each = try(each.value.include, null) != null ? [each.value] : []
      content {
        login_method      = try(each.value.include["login_method"], null)
        group             = try(each.value.include["group"], null)
        everyone          = try(each.value.include["everyone"], null)
    }
  }
    depends_on = [cloudflare_access_application.access_app]
}