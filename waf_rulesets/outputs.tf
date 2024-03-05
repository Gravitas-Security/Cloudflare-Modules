output "cloudflare_rulesets" {
  description = "Cloudflare managed WAF Rulesets for current zone"
  value       = cloudflare_ruleset.cf_managed_ruleset
}

output "cloudflare_ruleset_cf_rules" {
  description = "rules applied to rulesets"
  value       = cloudflare_ruleset.cf_managed_ruleset.rules
}

output "cloudflare_ruleset_owasp_rules" {
  description = "OWASP rules applied to rulesets"
  value       = data.cloudflare_rulesets.owasp_rulesets.rulesets
}

output "cloudflare_owasp_ruleset_rules" {
  description = "OWASP rules applied to rulesets"
  value       = local.cloudflare_owasp_ruleset
}

output "cloudflare_managed_ruleset_rules" {
  description = "OWASP rules applied to rulesets"
  value       = local.cf_managed_ruleset
}

# output "cloudflare_managed_all_ruleset_rules" {
#   description = "OWASP rules applied to rulesets"
#   value       = local.all_managed_ruleset
# }