output "filters" {
  description = "Created Cloudflare filters for the current zone."
  value       = cloudflare_filter.filters
}

output "rules" {
  description = "Created Cloudflare rules for the current zone."
  value       = cloudflare_firewall_rule.rules
}