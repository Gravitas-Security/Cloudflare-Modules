output "cloudflare_rulesets" {
    description = "Cloudflare managed WAF Rulesets for current zone"
    value       = cloudflare_ruleset.cf_managed_ruleset
}

output "cloudflare_ruleset_rules" {
    description = "rules applied to rulesets"
    value = cloudflare_ruleset.cf_managed_ruleset.rules
}

output "cloudflare_ruleset_overrides" {
    description = "rules applied to rulesets"
    value = cloudflare_waf_override.waf_overrides
}