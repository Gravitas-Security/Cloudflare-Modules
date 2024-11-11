data "cloudflare_accounts" "account" {
  name = var.account_name
}

resource "cloudflare_list" "lists" {
  account_id  = data.cloudflare_accounts.account.accounts.0.id
  for_each    = { for cf_list in var.account_lists : cf_list.name => cf_list }
  name        = each.value.name
  description = each.value.description
  kind        = each.value.kind

  dynamic "item" {
    for_each = each.value.item # Iterating over the item list

    content {
      value {
        ip  = each.value.kind == "ip" ? item.value.ip : null
        asn = each.value.kind == "asn" ? item.value.asn : null
      }
      comment = item.value.comment
    }
  }
}

resource "cloudflare_zero_trust_list" "teams_lists" {
  account_id  = data.cloudflare_accounts.account.accounts.0.id
  for_each    = { for cf_list in var.teams_lists : cf_list.name => cf_list }
  name        = each.value.name
  type        = each.value.type
  description = each.value.description
  items       = each.value.items
}
