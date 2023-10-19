output "cloudflare_account" {
  value = data.cloudflare_accounts.account.accounts.0
}

output "account_member" {
  value = cloudflare_account_member.account_member
}