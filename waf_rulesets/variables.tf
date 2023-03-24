variable "zone_id" {
  description = "Cloudflare domain to apply rules for."
  type        = string
  default = "zone_id"
}

variable "owasp_waf_settings" {
  type = object({
    score_threshold   = number
    action            = string
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
  default = "log"
  description = <<-DOC
  Allows for overriding of default values in the Cloudflare WAF package\
  #########################EXAMPLE####################\
    cf_waf_action = "block"\
  #######################END EXAMPLE##################\
  Valid options are `block`, `challenge`, `managed_challenge`, `js_challenge`, `log`
  DOC
}

variable "waf_overrides" {
  description = "List of Cloudflare owasp waf rule objects."
  type = map
}