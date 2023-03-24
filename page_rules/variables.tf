variable "zone_id" {
  description = "Cloudflare domain to apply rules for."
  type        = string
  default = "zone_id"
}
variable "page_rule_configs" {
  default     = []
  description = <<-DOC
    Provides a Cloudflare page rule resource.\
    ###############EXAMPLE########################## \
    {\
      target   = "https://www.bhhc.com/*" \
      status   = "disabled" \
      actions = {\
        forwarding_url = [{\
          status_code = "301"\
          url         = "https://www.bhhc.com"\
        }]\
      }\
    }\
    #############END EXAMPLE####################### \
    target:\
      (Required) The URL pattern to target with the page rule.\
    actions:\
      (Required) The actions taken by the page rule, options given below.\
    priority:\
      (Optional) The priority of the page rule among others for this target, the higher the number the higher the priority as per <href>API documentation.\
    status:\
      (Optional) Whether the page rule is active or disabled.\
  DOC
}