# locals {
#   app_keys = keys(var.application)
#   app_key_to_index = { for app, app_key in local.app_keys : app_key => app }
# }