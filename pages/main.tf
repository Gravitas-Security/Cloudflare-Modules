data "cloudflare_accounts" "account" {
  name = var.account_name
}

# Cloudflare Pages for Github integration
resource "cloudflare_pages_project" "pages_source_config" {
  account_id  = data.cloudflare_accounts.account.accounts.0.id
  for_each    = { for cf_pages in var.account_pages : cf_pages.name => cf_pages }
  name        = each.value.name
  production_branch = each.value.production_branch
  source {
    type = "github"
    config {
      owner                         = each.value.source_config[0].owner
      repo_name                     = each.value.source_config[0].repo_name
      production_branch             = each.value.production_branch
      pr_comments_enabled           = each.value.source_config[0].pr_comments_enabled == null ? true : each.value.source_config[0].pr_comments_enabled
      deployments_enabled           = each.value.source_config[0].deployments_enabled == null ? true : each.value.source_config[0].deployments_enabled
      production_deployment_enabled = each.value.source_config[0].production_deployment_enabled == null ? true : each.value.source_config[0].production_deployment_enabled
      preview_deployment_setting    = each.value.source_config[0].preview_branch_includes == null ? "all" : each.value.source_config[0].preview_deployment_setting
      preview_branch_includes       = each.value.source_config[0].preview_branch_includes
      preview_branch_excludes       = each.value.source_config[0].preview_branch_excludes
    }
  }
   build_config {
    build_command       = "npm run build"
    destination_dir     = "build"
    root_dir            = ""
  }
  deployment_configs {
    preview {
      environment_variables = {
        ENVIRONMENT = "preview"
      }
    }
    production {
      environment_variables = {
        ENVIRONMENT = "production"
      }
    }
  }
}

resource "cloudflare_pages_domain" "pages_domain" {
  for_each    = { for cf_pages in var.account_pages : cf_pages.name => cf_pages }
  account_id  = data.cloudflare_accounts.account.accounts.0.id
  project_name = each.value.name
  domain       = "${each.value.name}.${each.value.domain}"
  depends_on = [ cloudflare_pages_project.pages_source_config ]
}
data "cloudflare_zone" "zone" {
  for_each = { for cf_pages in var.account_pages : cf_pages.name => cf_pages }
  name     = each.value.domain
}

resource "cloudflare_record" "pages_record" {
  for_each    = { for cf_pages in var.account_pages : cf_pages.name => cf_pages }
  zone_id     = data.cloudflare_zone.zone[each.key].id
  name        = each.value.name
  type        = "CNAME"
  value       = cloudflare_pages_project.pages_source_config[each.key].subdomain
  proxied     = true
  depends_on = [ cloudflare_pages_domain.pages_domain ]
}