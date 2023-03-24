locals {
  normalize_page_rule_configs = { for idx, item in var.page_rule_configs : item["target"] => merge(
    item,
    {
      priority = length(var.page_rule_configs) - idx
  }) }
}