variable "domain" {
  description = "Cloudflare domain to apply rules for."
  type        = string
}

variable "owasp_rule_overrides" {
  description = "Allows for overriding of default values in the Cloudflare OWASP package"
  type        = list(object({
    rules              = list(string)
    action          = optional(string)
    expression = string
    score_threshold = optional(number)
    description = string
  }))
}

variable "cf_rule_overrides" {
  description = "Allows for overriding of default values in the Cloudflare OWASP package"
  type        = list(object({
    rules              = string
    action          = optional(string)
    expression = string
    description = string
  }))
}

variable "owasp_waf_settings" {
  type = object({
    score_threshold = optional(number)
    action          = optional(string)
  })
  default = {
    score_threshold = 40,
    action          = "log"
  }
  description = <<-DOC
  Allows for overriding of default values in the Cloudflare OWASP package\
  #########################EXAMPLE####################\
    owasp_waf_settings = {\
    action = "block"\
    score_threshold = 20\
  }\
  #######################END EXAMPLE##################\
  DOC    
}
variable "cf_waf_action" {
  default     = "log"
  description = <<-DOC
  Allows for overriding of default values in the Cloudflare WAF package\
  #########################EXAMPLE####################\
    cf_waf_action = "block"\
  #######################END EXAMPLE##################\
  Valid options are `block`, `challenge`, `managed_challenge`, `js_challenge`, `log`
  DOC
}