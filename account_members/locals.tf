locals {
  member_roles = { for member_name, member_attrs in var.members : member_name => member_attrs if can(member_attrs.roles) }

  role_names = flatten([
    for name, attrs in local.member_roles : [
      for role in attrs.roles : {
        name = name
        role = role
      } if can(attrs.roles)
    ]
  ])

  avail_roles = { for role in data.cloudflare_account_roles.account_roles.roles : role.name => role }
}