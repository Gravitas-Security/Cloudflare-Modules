variable "account_id" {
  type = string
}
# Zone settings
variable "domain" {}

variable "zone_on" {
  default = true
}

variable "plan" {
  default = "free"
}

variable "type" {
  default = "partial"
}

# Other A, CNAME, MX, TXT records
variable "records" {
  validation {
    condition     = can([for record in var.records : contains(["A", "AAAA", "CNAME", "TXT", "SRV", "MX"], record.type)])
    error_message = "Only the following action elements are allowed: A, AAAA, CNAME, MX, SRV, TXT."
  }
  description = <<-DOC
    Provides a Cloudflare record resource.\
    ###############EXAMPLE########################## \
    "accounts" = {\
      name     = "accounts" \
      value   = "174.143.32.211" \
      type    = "A" \
    }\
    #############END EXAMPLE####################### \
    name:\
      (Required) The name of the record. \
    value:\
      (Required) The (string) value of the record (Valid values are: `A`, `AAAA`, `CNAME`, `MX`, `TXT`).\
    type:\
      (Required) The type of the record.\
    ttl:\
       (Optional) The TTL of the record (default: `1`).\
    proxied: \
      (Optional) Whether the record gets Cloudflare's origin protection (default: `true`).\ 
  DOC
  default = {
    proxied = false
  }
}