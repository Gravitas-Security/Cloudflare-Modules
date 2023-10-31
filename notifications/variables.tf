variable "account_name" {
  description = "Cloudflare Account name"
  type        = string
}

variable "notification_policies" {
  description = "values for notification policy"
  type = map(object({
    type = string
    enabled = optional(bool)
    email = optional(string)
    webhook = optional(string)
    pager_duty = optional(string)
    filters = optional(list(object({})))
  }))
}

variable "webhooks" {
  description = "values for webhooks"
  type = map(object({
    name = string
    url = optional(string)
    secret = optional(string)
  }))
}