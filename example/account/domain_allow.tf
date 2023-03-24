resource "cloudflare_teams_list" "domain_allowlist" {
    account_id = "abcdefghijklmnop"
    name       = "allowed_domains"
    type       = "DOMAIN"
    description = "list of domains allowed through filtering"
    items       = [
        "example.com"
    ]
}