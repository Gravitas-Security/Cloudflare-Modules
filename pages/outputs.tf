output "cloudflare_pages_project" {
  value = nonsensitive(cloudflare_pages_project.pages_source_config)
}

output "cloudflare_pages_domain" {
  value = cloudflare_pages_domain.pages_domain
}