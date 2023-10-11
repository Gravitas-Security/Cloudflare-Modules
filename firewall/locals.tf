locals {
 rules = { for rule, item in var.rules : var.rules[rule]["expression"] => merge(
    item,
    {
      priority = rule + 3
    }
    )
  }
}