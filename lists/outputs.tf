output "lists" {
  description = "Created Cloudflare lists for the account."
  value       = cloudflare_list.lists
}

output "teams_lists" {
  description = "Created Cloudflare lists for teams."
  value       = cloudflare_teams_list.teams_lists
}