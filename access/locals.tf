locals {
  apps_with_hc = { for app in var.application : app.name => app if app.hc_path != null }
}
