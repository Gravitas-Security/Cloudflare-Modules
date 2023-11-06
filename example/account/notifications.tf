module "notification_policies" {
  source       = "github.com/Gravitas-Security/cloudflare-modules//notifications?ref=v2.3.0"
  account_name = "account name"

  notification_policies = {
    "origin_errors" = {
      description = "Notification policy to alert when origin sites are unreachable"
      type        = "real_origin_monitoring"
      email       = "someemail@example.com"
    }
    "ddos_alerts" = {
      description = "Notification policy to alert when DDOS attacks are detected"
      type        = "dos_attack_l7"
      email       = "someemail@example.com"
    }
  }
}