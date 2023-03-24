locals {
 rules = { for idx, item in var.rules : var.rules[idx]["expression"] => merge(
    item,
    {
      priority = idx + 1
    }
    )
  }
}