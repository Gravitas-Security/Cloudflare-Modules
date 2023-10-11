resource "cloudflare_list" "blacklist" {
  account_id  = "abcdefghijklmnop"
  name        = "blacklist"
  kind        = "ip"
  description = "List for blocking bad IP's"

  /*item {
    value {
      ip = "1.2.3.4/32"
      }
    comment = "example"
  }*/
}