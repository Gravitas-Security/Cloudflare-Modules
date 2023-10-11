# Zone settings
variable "account_id" {
  type = string
}
variable "gw_policies" {
  type = list(object({
    name   = string
    description  = string
    action = optional(string)
    enabled = optional(bool)
    filters = list(string)
    traffic  = string 
    rule_settings = optional(object({
      block_page_enabled = optional(bool)
      block_page_reason = optional(string)
      override_ips = optional(list(string))
      override_host = optional(string)
      insecure_disable_dnssec_validation = optional(bool)
    }))
  }))
  default = []
}
/*variable "dns_categories" {
  description   = "dns category ids"
  type          = map(string)
  default = {
    cat_adult_themes = 2
    adult_themes = 67
    nudity = 125
    pornography = 133
    cat_security_risks = 32
    new_domains = 169
    newly_seen_domains = 177
    no_content = 124
    parked_domains = 128
    unreachable = 161
 }
}*/