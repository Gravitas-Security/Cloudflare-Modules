variable "application" {
  description = "Ordered list of applications"
  type = list(object({
    name     = string
    group    = string
    decision = optional(string)
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