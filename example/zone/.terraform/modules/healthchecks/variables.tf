variable "domain" {
  description = "Cloudflare zone name"
  type        = string
}

variable "healthchecks" {
  type = map(object({
    description = string
    type        = optional(string)
    address     = string
    path        = string
    interval    = optional(number)
    threshold   = optional(number)
    timeout     = optional(number)
    retries     = optional(number)
    method      = optional(string)
    port        = optional(number)
    headers = optional(map(object({
      header = string
      values = list(string)
    })))
    regions               = optional(list(string))
    follow_redirects      = optional(bool)
    expected_body         = optional(string)
    expected_codes        = optional(list(number))
    allow_insecure        = optional(bool)
    enabled               = optional(bool)
    consecutive_successes = optional(number)
  }))
}