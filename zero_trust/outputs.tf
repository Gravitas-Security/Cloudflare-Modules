output "gateway_policies" {
  description = "Cloudflare DNS Gateway Policies"
  value       = cloudflare_zero_trust_gateway_policy.gateway_policies
}
