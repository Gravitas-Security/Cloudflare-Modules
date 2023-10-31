output "notification_policies" {
  value = cloudflare_notification_policy.notification
}

output "webhooks" {
  value = cloudflare_notification_policy_webhooks.webhooks
}