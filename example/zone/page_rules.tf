module "page_rules" {
  source     = "../../../modules/page_rules"
  zone_id    = module.dns_zones.zone_id
  depends_on = [module.dns_zones]
#  page_rule_configs = [
#    {
#      target = "https://www.example.com"
#      status = "active"
#      actions = {
#        forwarding_url = [{
#          status_code = "301"
#          url         = "https://thing.com/example"
#        }]
#      }
#    }
#  ]
}
