variable "account_id" {
  description = "Cloudflare Account_ID"
  type        = string
}

variable "users" {
  description = "map of users - roles"
  type        = map(list(string))
}

variable "member_roles" {
  description = "account role ids"
  type        = map(string)
  default = {
    super_admin      = "33666b9c79b9a5273fc7344ff42f953d"
    admin            = "05784afa30c1afe1440e79d9351c7430"
    admin_ro         = "f2b20eaa1a5d4af42b53ac16238c99c7"
    analytics        = "6ddc5f80969d01105b5a0931e0079365"
    audit_log_viewer = "9dfa4d1b73034f70ad896bf1c26d78f3"
    billing          = "298ce8e7a2ba08b9d18ce0a32bb458ee"
    cache_purge      = "d1c17a97abf0aa371338074955877ba0"
    dns_edit         = "069fe803647ed3609e93d041d5df6050"
    zt_ro            = "156a872fa6df06e0e9b85d32afce6990"
    zt_report        = "b525e80fc64a4323a9ea666467d1865c"
  }
}