variable "zone_id" {
  description = "Cloudflare domain to apply rules for."
  type        = string
  default = "zone_id"
}

variable "rules" {
  type = list(object({
    description = string
    paused      = bool
    action      = string
    expression  = string
    products    = list(string)
  }))
  default = []

  # Ensure we specify only allows action values
  # https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/firewall_rule#action
  validation {
    condition     = can([for rule in var.rules : contains(["block", "challenge", "allow", "js_challenge", "bypass", "log"], rule.action)])
    error_message = "Only the following action elements are allowed: block, challenge, allow, js_challenge, bypass, log."
  }

  # Ensure we specify only allowed products values
  # https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/firewall_rule#products
  validation {
    condition     = can([for rule in var.rules : [for product in rule.products : contains(["zoneLockdown", "uaBlock", "bic", "hot", "securityLevel", "rateLimit", "waf"], product)]])
    error_message = "Only the following product elements are allowed: zoneLockdown, uaBlock, bic, hot, securityLevel, rateLimit, waf."
  }
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