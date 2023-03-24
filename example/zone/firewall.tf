
module "firewall" {
  source     = "../../../modules/firewall"
  zone_id    = module.dns_zones.zone_id
  depends_on = [module.dns_zones]
  rules = [
    /*{
    description = "Test (WAF Bypass)"
    paused      = false
    priority    = 2
    action      = "bypass"
    expression  = "(http.user_agent contains \"UA-TEST/\" and ip.src eq 1.2.3.4 and http.request.uri.path eq \"/api/endpoint\")"
    products    = ["waf"]
  }*/
  ]
}