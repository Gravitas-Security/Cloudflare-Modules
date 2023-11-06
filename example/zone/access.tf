module "access_app" {
  source     = "github.com/cyberviking949/cloudflare-modules//access?ref=v1.0.0"
  domain             = "zone name"
  depends_on = [module.dns_zones]


  group = {
    "example_group" = {
      name = "example_group"
      include = {
        login_method = ["teyjh5tyejhtyejhtyjhertyjuh7tyj"] //OAuth provider ID in Cloudflare
      }
    }
  }
  application = {
    "thing1.example.com" = {
      domain = "thing1.example.com"
      name   = "thing1 Access"
    }
    "thing2.example.com" = {
      domain = "thing2.example.com"
      name   = "thing2 Access"
    }
  }
  policy = {
    "allow_thing1" = {
      name        = "Allow thing1"
      application = "thing1.example.com"
      decision    = "allow"
      precedence  = 1
      include = {
        login_method = ["teyjh5tyejhtyejhtyjhertyjuh7tyj"]
      }
    }
    "allow_thing2" = {
      name        = "Allow thing2"
      application = "thing2.example.com"
      decision    = "allow"
      precedence  = 2
      include = {
        login_method = ["teyjh5tyejhtyejhtyjhertyjuh7tyj"]
      }
    }
  }
}
