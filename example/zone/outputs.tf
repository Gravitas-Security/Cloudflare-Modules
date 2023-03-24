# Zone information

output "ns" {
  value = module.dns_zones.name_servers
}

output "zone_id" {
  value = module.dns_zones.zone_id
}

output "status" {
  value       = module.dns_zones.status
  description = "Status of the zone. Valid values: active, pending, initializing, moved, deleted, deactivated."
}

# cloudflare_record resource

output "ids" {
  value       = module.dns_zones.ids
  description = "The record IDs."
}

output "hostnames" {
  value       = module.dns_zones.hostnames
  description = "The FQDN of the records."
}

output "proxiable" {
  value       = module.dns_zones.proxiable
  description = "Shows whether these records can be proxied, must be true if setting proxied=true."
}

output "created_on" {
  value       = module.dns_zones.created_on
  description = "The RFC3339 timestamp of when the records were created."
}

output "modified_on" {
  value       = module.dns_zones.modified_on
  description = "The RFC3339 timestamp of when the records were last modified."
}

output "metadata" {
  value       = module.dns_zones.metadata
  description = "A key-value map of string metadata Cloudflare associates with the records."
}

# Firewall Outputs
output "filters" {
  description = "Created Cloudflare filters for the current zone."
  value       = module.firewall.filters
}

output "rules" {
  description = "Created Cloudflare rules for the current zone."
  value       = module.firewall.rules
}

# WAF Outputs
output "cloudflare_rulesets" {
  description = "Cloudflare managed WAF Rulesets for current zone"
  value       = module.waf_rulesets.cloudflare_rulesets
}

output "cloudflare_ruleset_rules" {
  description = "rules applied to rulesets"
  value       = module.waf_rulesets.cloudflare_ruleset_rules
}

output "cloudflare_ruleset_overrides" {
  description = "rules applied to rulesets"
  value       = module.waf_rulesets.cloudflare_ruleset_overrides
}

# Access Outputs
output "cloudflare_access_group" {
  description = "access groups"
  value       = module.access_app.cloudflare_access_group
}

output "cloudflare_access_app" {
  description = "application"
  value       = module.access_app.cloudflare_access_application
}

output "cloudflare_access_policy" {
  description = "application policies"
  value       = module.access_app.cloudflare_access_policy
}

# Zero-Trust Outputs
output "gateway_policies" {
  description = "zero-trust policies for DNS Gateways"
  value       = module.zero_trust.gateway_policies
}


