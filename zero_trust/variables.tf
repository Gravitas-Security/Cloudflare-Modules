# Zone settings
variable "account_id" {
  type = string
}
variable "gw_policies" {
  type = map
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