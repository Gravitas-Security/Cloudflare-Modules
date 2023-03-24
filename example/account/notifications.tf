resource "cloudflare_notification_policy" "origin_errors" {
  account_id = "abcdefghijklmnop"
  name = "Policy for origin sites"
  description = "Notification policy to alert when origin sites are unreachable"
  enabled     =  true
  alert_type  = "real_origin_monitoring"

  email_integration {
    id   =  "example@example.com"
  }
}

resource "cloudflare_notification_policy" "_5xx_errors" {
  account_id = "abcdefghijklmnop"
  name = "Policy for origin errors"
  description = "Notification policy to alert when origin sites are throwing high level of 5XX errors"
  enabled     =  true
  alert_type  = "http_alert_origin_error"
  filters     {
    zones = ["abcdefghijklmnop"]
    //slo = [99.9]
  }

  email_integration {
    id   =  "example@example.com"
  }
}

resource "cloudflare_notification_policy" "ddos_alerts" {
  account_id = "abcdefghijklmnop"
  name = "Policy for ddos alerts"
  description = "Notification policy to alert when DDOS attacks are detected"
  enabled     =  true
  alert_type  = "dos_attack_l7"

  email_integration {
    id   =  "example@example.com"
  }
}

resource "cloudflare_notification_policy" "waf_alerts" {
  account_id = "abcdefghijklmnop"
  name = "Policy for waf alerts"
  description = "Notification policy to alert when CF detects a spike in WAF events"
  enabled     =  true
  alert_type  = "clickhouse_alert_fw_anomaly"
  filters     {
    zones = ["abcdefghijklmnop"]
  }

  email_integration {
    id   =  "example@example.com"
  }
}

resource "cloudflare_notification_policy" "sec_alerts" {
  account_id = "abcdefghijklmnop"
  name = "Policy for security alerts"
  description = "Notification policy to alert when CF detects a spike in security events"
  enabled     =  true
  alert_type  = "clickhouse_alert_fw_ent_anomaly"
  filters     {
    zones = ["abcdefghijklmnop"]
    services = ["firewallManaged"]
  }

  email_integration {
    id   =  "example@example.com"
  }
}