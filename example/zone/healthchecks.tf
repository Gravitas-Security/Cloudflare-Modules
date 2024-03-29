
module "healthchecks" {
  source = "github.com/cyberviking949/cloudflare-modules//healthchecks?ref=v2.6.0"

  domain     = "zone name"
  depends_on = [module.dns_zones]

  healthchecks = [
    {
      name          = "thingy"
      description   = "thingy healthcheck"
      address       = "thingy"
      path          = "health"
      expected_body = "alive"
    }
  ]
}