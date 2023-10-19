variable "domain" {
  description = "Cloudflare domain to apply rules for."
  type        = string
}

variable "rules" {
  type = list(object({
    name             = string
    description      = string
    action           = string
    expression       = string
    skipped_products = optional(list(string))
    skipped_phases   = optional(list(string))
    logging          = optional(bool)
  }))
  default = []

  # Ensure we specify only allows action values
  # https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/firewall_rule#action
  validation {
    condition     = can([for rule in var.rules : contains(["block", "challenge", "compress_response", "ddos_dynamic", "ddos_mitigation", "execute", "force_connection_close", "js_challenge", "log", "log_custom_field", "managed_challenge", "redirect", "rewrite", "route", "score", "serve_error", "set_cache_settings", "set_config", "skip"], rule.action)])
    error_message = "Only the following action elements are allowed: block, challenge, compress_response, ddos_dynamic, ddos_mitigation, execute, force_connection_close, js_challenge, log, log_custom_field, managed_challenge, redirect, rewrite, route, score, serve_error, set_cache_settings, set_config, skip"
  }

  # Ensure we specify only allowed products values
  # https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/firewall_rule#products
  # validation {
  #   condition     = can([for rule in var.rules : [for product in rule.skipped_products != null : contains(["zoneLockdown", "uaBlock", "bic", "hot", "securityLevel", "rateLimit", "waf"], product)]])
  #   error_message = "Only the following product elements are allowed: zoneLockdown, uaBlock, bic, hot, securityLevel, rateLimit, waf."
  # }

  # validation {
  #   condition     = can([for rule in var.rules : [for phase in rule.skipped_phases != null : contains(["http_ratelimit", "http_request_sbfm", "http_request_firewall_managed"], phase)]])
  #   error_message = "Only the following product elements are allowed: http_ratelimit, http_request_sbfm, http_request_firewall_managed."
  # }
  description = <<-DOC
    Provides a Cloudflare record resource.\
    ###############EXAMPLE########################## \
    {\
    description = "Test (WAF Bypass)"\
    paused      = false\
    action      = "bypass"\
    expression  = "(http.user_agent contains \"UA-TEST/\" and ip.src eq 1.2.3.4 and http.request.uri.path eq \"/api/endpoint\")"\
    products    = ["waf"]\
  }\
    #############END EXAMPLE####################### \
    paused:\
      (Optional) Whether this filter is currently paused. `Boolean` value. \
    expression:\
      (Required) The filter expression to be used.\
    description:\
      (Optional) A note that you can use to describe the purpose of the filter.\
    ref:\
      (Optional) Short reference tag to quickly select related rules.\
    products:\
      (Optional) List of products to bypass for a request when the bypass action is used. Allowed values: `zoneLockdown`, `uaBlock`, `bic`, `hot`, `securityLevel`, `rateLimit`, `waf`.
  DOC
}