data "cloudflare_accounts" "account" {
  name = var.account_name
}

resource "cloudflare_notification_policy" "notification" {
  for_each = var.notification_policies
  account_id  = data.cloudflare_accounts.account.accounts[0].id
  name     = each.key
  alert_type     = each.value.type #Available values: advanced_http_alert_error, access_custom_certificate_expiration_type, advanced_ddos_attack_l4_alert, advanced_ddos_attack_l7_alert, bgp_hijack_notification, billing_usage_alert, block_notification_block_removed, block_notification_new_block, block_notification_review_rejected, clickhouse_alert_fw_anomaly, clickhouse_alert_fw_ent_anomaly, custom_ssl_certificate_event_type, dedicated_ssl_certificate_event_type, dos_attack_l4, dos_attack_l7, expiring_service_token_alert, failing_logpush_job_disabled_alert, fbm_auto_advertisement, fbm_dosd_attack, fbm_volumetric_attack, health_check_status_notification, hostname_aop_custom_certificate_expiration_type, http_alert_edge_error, http_alert_origin_error, load_balancing_health_alert, load_balancing_pool_enablement_alert, real_origin_monitoring, scriptmonitor_alert_new_code_change_detections, scriptmonitor_alert_new_hosts, scriptmonitor_alert_new_malicious_hosts, scriptmonitor_alert_new_malicious_scripts, scriptmonitor_alert_new_malicious_url, scriptmonitor_alert_new_max_length_resource_url, scriptmonitor_alert_new_resources, secondary_dns_all_primaries_failing, secondary_dns_primaries_failing, secondary_dns_zone_successfully_updated, secondary_dns_zone_validation_warning, sentinel_alert, stream_live_notifications, tunnel_health_event, tunnel_update_event, universal_ssl_event_type, web_analytics_metrics_update, weekly_account_overview, workers_alert, zone_aop_custom_certificate_expiration_type.
  enabled = each.value.enabled == null ? true : each.value.enabled
  dynamic "email_integration" {
    for_each = try(each.value.email, null) != null ? [each.value.email] : []
    content {
      id = each.value.email
    }
  }
  dynamic "webhooks_integration" {
    for_each = try(each.value.webhook, null) != null ? [each.value.webhook] : []
    content {
      id = cloudflare_notification_policy_webhooks.webhooks[each.value.webhook].id
    }
  }
  dynamic "pagerduty_integration" {
    for_each = try(each.value.pagerduty, null) != null ? [each.value.pagerduty] : []
    content {
      id = each.value.pagerduty
    }
  }
  dynamic "filters" {
    for_each = each.value.filters != null ? [each.value.filters] : []
    content {
      actions = try(each.value.filters.actions, null)
      alert_trigger_preferences = try(each.value.filters.alert_trigger_preferences, null)
      enabled = try(each.value.filters.enabled, null)
      environment = try(each.value.filters.environment, null)
      event = try(each.value.filters.event, null)
      event_source = try(each.value.filters.event_source, null)
      event_type = try(each.value.filters.event_type, null)
      group_by = try(each.value.filters.group_by, null)
      health_check_id = try(each.value.filters.health_check_id, null) #Required when using status
      input_id = try(each.value.filters.input_id, null)
      limit = try(each.value.filters.limit, null)
      megabits_per_second = try(each.value.filters.megabits_per_second, null)
      new_health = try(each.value.filters.new_health, null)
      packets_per_second = try(each.value.filters.packets_per_second, null)
      pool_id = try(each.value.filters.pool_id, null)
      product = try(each.value.filters.product, null) #Available Values = worker_requests, worker_durable_objects_requests, worker_durable_objects_duration, worker_durable_objects_data_transfer, worker_durable_objects_stored_data, worker_durable_objects_storage_deletes, worker_durable_objects_storage_writes, worker_durable_objects_storage_reads.
      project_id = try(each.value.filters.project_id, null)
      protocol = try(each.value.filters.protocol, null)
      requests_per_second = try(each.value.filters.requests_per_second, null)
      services = try(each.value.filters.services, null)
      slo = try(each.value.filters.slo, null)
      status = try(each.value.filters.status, null) #Available Values = up, degraded, down.
      target_hostname = try(each.value.filters.target_hostname, null)
      target_zone_name = try(each.value.filters.target_zone_name, null)
      where = try(each.value.filters.where, null)
      zones = try(each.value.filters.zones, null)
    }
  }

  lifecycle {
    ignore_changes = [id]
  }
  depends_on = [ cloudflare_notification_policy_webhooks.webhooks ]
}

data "aws_secretsmanager_secrets" "secret" {
  for_each = var.webhooks
  filter {
    name   = "name"
    values = [each.value.secret]
  }
}

resource "cloudflare_notification_policy_webhooks" "webhooks" {
  for_each = var.webhooks
  account_id = data.cloudflare_accounts.account.accounts[0].id
  name       = each.key
  url        = each.value.url
  secret     = each.value.secret #Exact Name of the secret in AWS Secrets manager
}