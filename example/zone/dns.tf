module "dns_zones" {
  source = "github.com/cyberviking949/cloudflare-modules//dns?ref=v1.0.0"

  domain = "example.com"
  type   = "full"
  plan   = "pro"
  account_id = "ekgvijaelroijvhneadsloikvhnaerdflohijv"


  records = {
    "example_com_wild" = {
      name    = "*"
      value   = "something.something.com"
      type    = "CNAME"
      proxied = true
    }
    "example_com_root" = {
      name    = "@"
      value   = "x.x.x.x"
      type    = "A"
      proxied = true
    }
    "www" = {
      name    = "www"
      value   = "something.something.com"
      type    = "CNAME"
      proxied = true
    }
    "mx" = {
      name     = "@"
      value    = "something02b.mail.protection.outlook.com "
      priority = 37
      type     = "MX"
    }
    "spf" = {
      name  = "@"
      value = "v=spf1 include:spf.protection.outlook.com ~all"
      type  = "TXT"
    }
    "dmarc" = {
      name  = "_dmarc"
      value = "v=DMARC1; p=reject"
      type  = "TXT"
    }
    "selector1._domainkey" = {
      name  = "selector1._domainkey"
      value = "stuff.onmicrosoft.com"
      type  = "CNAME"
      proxied = false
    }
    "selector2._domainkey" = {
      name  = "selector2._domainkey"
      value = "stuff.onmicrosoft.com"
      type  = "CNAME"
      proxied = false
    }
  }
}
