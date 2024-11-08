variable "account_name" {
  description = "Cloudflare Account name"
  type        = string
}

variable "account_pages" {
  type = list(object({
    name        = string
    production_branch = string
    domain      = string
    source_config = optional(list(object({
      owner = optional(string)
      repo_name            = optional(string)
      pr_comments_enabled   = optional(bool)
      deployments_enabled   = optional(bool)
      production_deployment_enabled = optional(bool)
      preview_deployment_setting = optional(string)
      preview_branch_includes       = list(string)
      preview_branch_excludes       = list(string)
    })))
    build_configs = optional(list(object({
      build_command       = optional(string)
      destination_dir     = optional(string)
      root_dir            = optional(string)
    })))
    deployment_configs = optional(object({
      preview = optional(object({
        environment_variables = optional(map(string))
      }))
      production = optional(object({
        environment_variables = optional(map(string))
      }))
    }))
  }))
  default     = []
  description = <<DOC
  ### Page Example ###\
  {
        name        = "www"
        production_branch = "main"
        domain = "example.com"
        source_config = [
        {
            owner  = "example name"
            repo_name   = "example-repo"
            preview_deployment_setting = "custom"
            preview_branch_includes = ["*"]
            preview_branch_excludes = ["main"]
        }
        ]
    }
  DOC
}