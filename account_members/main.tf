data "cloudflare_accounts" "account" {
  name = var.account_name
}

data "cloudflare_account_roles" "account_roles" {
  account_id = data.cloudflare_accounts.account.accounts.0.id
}

resource "cloudflare_account_member" "account_member" {
  account_id    = data.cloudflare_accounts.account.accounts.0.id
  for_each      = { for member in local.role_names : "${member.name}-${member.role}" => member }
  email_address = lower(each.value.name)
  role_ids      = [local.avail_roles[each.value.role].id]
}