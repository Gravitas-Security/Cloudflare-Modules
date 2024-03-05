module "lists" {
  source       = "github.com/cyberviking949/cloudflare-modules//lists?ref=v2.6.0"
  account_name = "account name"

  account_lists = [
    {
      name        = "blacklist"
      kind        = "ip"
      description = "List for blocking bad IP's"
      item = [
        #  {
        #     ip = ""
        #     comment = ""
        #  }
      ]
    },
    {
      name        = "nessus_scanners"
      kind        = "ip"
      description = "List for allowing scanners"
      item = [
        {
          ip      = "34.201.223.128/25"
          comment = "us-east-1"
          }, {
          ip      = "44.192.244.0/24"
          comment = "us-east-1"
          }, {
          ip      = "54.175.125.192/26"
          comment = "us-east-1"
          }, {
          ip      = "13.59.252.0/25"
          comment = "us-east-2"
          }, {
          ip      = "18.116.198.0/24"
          comment = "us-east-2"
          }, {
          ip      = "3.132.217.0/25"
          comment = "us-east-2"
          }, {
          ip      = "13.56.21.128/25"
          comment = "us-west-1"
          }, {
          ip      = "3.101.175.0/25"
          comment = "us-west-1"
          }, {
          ip      = "54.219.188.128/26"
          comment = "us-west-1"
          }, {
          ip      = "34.223.64.0/25"
          comment = "us-west-2"
          }, {
          ip      = "35.82.51.128/25"
          comment = "us-west-2"
          }, {
          ip      = "35.86.126.0/24"
          comment = "us-west-2"
          }, {
          ip      = "44.242.181.128/25"
          comment = "us-west-2"
        }
      ]
    }
  ]

  teams_lists = [
    {
      name        = "allowed_domains_new"
      type        = "DOMAIN"
      description = "list of domains allowed through filtering"
      items = [
        "abcd.com",
        "efgh.com"
      ]
    }
  ]
}