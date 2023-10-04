output "rules" {
  description = "Created Cloudflare rules for the current zone."
  value       = cloudflare_ruleset.rulesets
}