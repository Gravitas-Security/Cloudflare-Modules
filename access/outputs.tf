output "cloudflare_access_group" {
  description = "Cloudflare access group"
  value       = cloudflare_access_group.group
}

output "cloudflare_access_application" {
  description = "Access Application"
  value       = cloudflare_access_application.access_app
}

output "cloudflare_access_policy" {
  description = "Access Application Policies"
  value       = cloudflare_access_policy.app_policy
}