# Overview

A module for enforcing Cloudflare configuration states with Terraform IaC.

### Cloudflare Notifications Configurations
```hcl
module "notification_policies" {
  source = "github.com/Gravitas-Security/cloudflare-modules//notifications?ref=v2.3.0"
  account_name = "Gravitas Security"

  notification_policies = {
    "origin_errors" = {
      description = "Notification policy to alert when origin sites are unreachable"
      type  = "real_origin_monitoring"
      email = "someemail@example.com"
}
    "ddos_alerts" ={
      description = "Notification policy to alert when DDOS attacks are detected"
      type = "dos_attack_l7"
      email = "someemail@example.com"

    webhooks = {
        slack = {
            name = "slack_webhook"
            url = "https://slack.com/wioeurfviowerughbfiwoeruhgb"
            secret = "your_secretsmanager_secret_name"
        }
    }

}
```


## Assigning access to applications
1. Notification creation
  - supports multiple varieties. webhooks, pagerduty, and email
2. Webhooks
    - secret stored in aws Secrets manager. Will retrieve dynamically based on name provided

## TODO
* N/A