variable "application" {
  description = "Ordered list of applications"
  type = list(object({
    name     = string
    group    = string
    decision = optional(string)
    hc_body = optional(string)
    hc_codes = optional(list(string))
    hc_path = optional(string)
    hc_port = optional(number)
  }))
  default = []
}

variable "group" {
  type = list(object({
    name = string
    include = object({
      login_method = list(string)
    })
  }))
  default = []
}

variable "domain" {
  type    = string
  default = "domain"
}