# Zone information
output "domain" {
  value = var.domain
}
output "zone_id" {
  value       = cloudflare_zone.domain.id
  description = "The zone ID."
}

output "plan" {
  value       = cloudflare_zone.domain.plan
  description = "The name of the commercial plan to apply to the zone."
}

output "vanity_name_servers" {
  value       = cloudflare_zone.domain.vanity_name_servers
  description = "List of Vanity Nameservers (if set)."
}

output "meta_wildcard_proxiable" {
  value       = cloudflare_zone.domain.meta.wildcard_proxiable
  description = "Indicates whether wildcard DNS records can receive Cloudflare security and performance features."
}

output "meta_phishing_detected" {
  value       = cloudflare_zone.domain.meta.phishing_detected
  description = "Indicates if URLs on the zone have been identified as hosting phishing content."
}

output "status" {
  value       = cloudflare_zone.domain.status
  description = "Status of the zone. Valid values: active, pending, initializing, moved, deleted, deactivated."
}

output "name_servers" {
  value       = cloudflare_zone.domain.name_servers
  description = "Cloudflare-assigned name servers. domain is only populated for zones that use Cloudflare DNS."
}

output "verification_key" {
  value       = cloudflare_zone.domain.verification_key
  description = "Contains the TXT record value to validate domain ownership. domain is only populated for zones of type partial."
}

# cloudflare_zone_settings_override resource

output "initial_settings" {
  value       = cloudflare_zone_settings_override.domain_settings.initial_settings
  description = "Settings present in the zone at the time the resource is created. domain will be used to restore the original settings when domain resource is destroyed. Shares the same schema as the settings attribute (Above)."
}

output "initial_settings_read_at" {
  value       = cloudflare_zone_settings_override.domain_settings.initial_settings_read_at
  description = "Time when domain resource was created and the initial_settings were set."
}

output "readonly_settings" {
  value       = cloudflare_zone_settings_override.domain_settings.readonly_settings
  description = "Which of the current settings are not able to be set by the user. Which settings these are is determined by plan level and user permissions."
}

output "zone_type" {
  value       = cloudflare_zone_settings_override.domain_settings.zone_type
  description = "A full zone implies that DNS is hosted with Cloudflare. A partial zone is typically a partner-hosted zone or a CNAME setup."
}

# cloudflare_record resource

output "ids" {
  value       = { for k, v in cloudflare_record.records : k => v.id }
  description = "The record IDs."
}

output "hostnames" {
  value       = { for k, v in cloudflare_record.records : k => v.hostname }
  description = "The FQDN of the records."
}

output "proxiable" {
  value       = { for k, v in cloudflare_record.records : k => v.proxiable }
  description = "Shows whether these records can be proxied, must be true if setting proxied=true."
}

output "created_on" {
  value       = { for k, v in cloudflare_record.records : k => v.created_on }
  description = "The RFC3339 timestamp of when the records were created."
}

output "modified_on" {
  value       = { for k, v in cloudflare_record.records : k => v.modified_on }
  description = "The RFC3339 timestamp of when the records were last modified."
}

output "metadata" {
  value       = { for k, v in cloudflare_record.records : k => v.metadata }
  description = "A key-value map of string metadata Cloudflare associates with the records."
}