data "cloudflare_zones" "zones" {
  filter {
    name = var.domain
  }
}

resource "cloudflare_healthcheck" "healthchecks" {
  for_each = var.healthchecks
  zone_id = data.cloudflare_zones.zones.zones[0].id
  name = each.key
  description = each.value.description
  address = "${each.value.address}.${var.domain}"
  suspended = each.value.enabled
  check_regions = each.value.regions != null ? each.value.regions : ["ALL_REGIONS"]
  type = each.value.type != null ? each.value.type : "HTTPS"
  port = each.value.port != null ? each.value.port : 443
  method = each.value.method != null ? each.value.method : "GET"
  path = each.value.path
  expected_body = each.value.expected_body != null ? each.value.expected_body : "alive"
  expected_codes = each.value.expected_codes != null ? each.value.expected_codes : ["2xx"]
  follow_redirects = each.value.follow_redirects != null ? each.value.follow_redirects : true
  allow_insecure = false
  dynamic header {
    for_each = each.value.headers != null ? each.value.headers : {}
    content {
      header = header.key
      values = header.value
    }
  }
  timeout = each.value.timeout != null ? each.value.timeout : 10
  retries = each.value.retries != null ? each.value.retries : 3
  interval = each.value.interval != null ? each.value.interval : 10
  consecutive_fails = each.value.threshold != null ? each.value.threshold : 3
  consecutive_successes = each.value.consecutive_successes != null ? each.value.consecutive_successes : 2

}