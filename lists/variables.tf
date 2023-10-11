variable "account_id" {
  description = "Cloudflare Account_ID"
  type        = string
}

variable "account_lists" {
  type = list(object({
    name             = string
    description      = string
    kind           = string
    item = list(object({
      ip = optional(string)
      redirect = optional(list(object({
        source_url            = string
        target_url            = string
        include_subdomains    = optional(string)
        subpath_matching      = optional(string)
        status_code           = optional(number)
        preserve_query_string = optional(string)
        preserve_path_suffix  = optional(string)
      })))
      asn = optional(number)
      hostname = optional(list(object({
        url_hostname = string
    })))
      comment = string
    }))
  }))
  default = []
  description = <<DOC
  ### IP List Example ###\
  {\
    name = "blacklist"\
    kind = "ip"\
    description = "List for blocking bad IP's"\
    item = [\
       {\
         value = "1.2.3.4"\
         comment = ""\
         }\
       }\
]
  }
  ### ASN List Example ###\
  {\
    name = "blacklist"\
    kind = "asn"\
    description = "List for blocking bad ASN's"\
    item = [\
       {\
         value = "7865795"\
         comment = ""\
       }\
  ]\
  }
  ### Hostname List Example ###\
  {\
    name = "blacklist"\
    kind = "hostname"\
    description = "List for blocking bad Hostnames"\
    item = [\
       {\
         value = "test.example.com"\
         comment = ""\
       }\
  ]\
  }
  ### Redirect List Example ###\
  {\
    name = "blacklist"\
    kind = "redirect"\
    description = "List for blocking bad URL's"\
    item = [\
       {\
        source_url            = "example.com/foo"\
        target_url            = "https://foo.example.com"\
        include_subdomains    = "enabled"\
        subpath_matching      = "enabled"\
        status_code           = 301\
        preserve_query_string = "enabled"\
        preserve_path_suffix  = "disabled"\
          comment = ""\
       }\
  ]\
  }
  DOC
}

variable "teams_lists" {
  type = list(object({
    name             = string
    description      = string
    type           = string
    items = list(string)
  }))
  default = []
  description = <<DOC
  ### DOMAIN List Example ###\
  {\
    name = "allow_list"\
    type = "DOMAIN"\
    description = "List for domains"\
    item = [\
         "abc.com",\
         "def.com"\
         ]\
  }
  ### IP List Example ###\
  {\
    name = "ip_list"\
    type = "IP"\
    description = "List for IP's"\
    item = [\
         "1.2.3.4",\
         "5.6.7.8"\
  ]\
  }
  ### SERIAL List Example ###\
  {\
    name = "serial"\
    type = "SERIAL"\
    description = "List for blocking bad Hostnames"\
    item = [\
         "fgxbnfdxbnfdsnb",\
         "dsfghnhmhjkmjmh"\
  ]\
  }
  ### URL List Example ###\
  {\
    name = "urls"\
    type = "URL"\
    description = "List for URL's"\
    item = [\
        "example.com/foo",\
        "foo.example.com"\
  ]\
  }
  DOC
}
