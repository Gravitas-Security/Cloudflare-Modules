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
    for_each = var.application
    zone_id    = var.zone_id
    application_id = cloudflare_access_application.access_app[each.key].id
    name = cloudflare_access_application.access_app[each.key].name
    decision = "allow"
    precedence =  each.value.precedence
    dynamic "include" {
      for_each = try(each.value, null) != null ? [each.value] : []
      content {
        #login_method      = try(each.value.login_method, null)
        group             = [cloudflare_access_group.group[each.value.group].id] #try(each.value.group, null)
        #everyone          = try(each.value.everyone, null)
  }
    }
    depends_on = [cloudflare_access_application.access_app]
}