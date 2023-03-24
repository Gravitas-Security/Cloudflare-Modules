# list information

output "blacklist" {
  value = cloudflare_list.blacklist.id
}

output "domain_allow" {
  value = cloudflare_teams_list.domain_allowlist.id
}
