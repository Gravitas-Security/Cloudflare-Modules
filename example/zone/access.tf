module "access_app" {
  source = "github.com/Gravitas-Security/cloudflare-modules//access?ref=v2.6.0"

  domain     = "example.com"
  depends_on = [module.dns_zones]


  group = [
    {
      name = "test_group"
      include = {
        login_method = ["sddvkchsaLIKFCHLskadjcvhbelsdkfajihbgv"] //jumpcloud
      }
    }
  ]
  application = [
    {
      name    = "thing1"
      group   = "test_group"
      hc_path = "/cgi-bin/"
      hc_port = 8443
      }, {
      name    = "thing2"
      group   = "test_group"
      hc_path = "/ping"
      }
  ]
}
