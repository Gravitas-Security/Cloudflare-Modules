locals {
  apps_with_hc = [for app in var.application : {
    name     = app.name
    hc_path  = app.hc_path
    hc_body  = app.hc_body
    hc_codes = app.hc_codes
  } if app.hc_path != null]
}
