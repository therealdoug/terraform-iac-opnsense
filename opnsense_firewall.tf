module "firewall_category_terraform_managed" {
  source = "./modules/terraform-firewall-category"

  count = var.terraform_annotation ? 1 : 0
  name  = "terraform_managed"
  auto  = true
  color = "purple"
}

module "firewall_category" {
  source = "./modules/terraform-firewall-category"

  for_each = { for category in try(local.opnsense.firewall.categories, []) : category.name => category }
  name     = each.value.name
  auto     = try(each.value.auto, false)
  color    = try(each.value.color, "")
}

module "firewall_alias" {
  source = "./modules/terraform-firewall-alias"

  for_each = { for alias in try(local.opnsense.firewall.alias, []) : alias.name => alias if alias.type != "networkgroup" }
  name     = each.value.name
  type     = each.value.type
  # categories    = try([for cat in each.value.categories : "${module.firewall_category[cat].id}"], [])
  categories    = var.terraform_annotation && var.manage_alias_category ? concat(try([for cat in each.value.categories : "${module.firewall_category[cat].id}"], []), ["${module.firewall_category_terraform_managed[0].id}"]) : try([for cat in each.value.categories : "${module.firewall_category[cat].id}"], [])
  content       = try(each.value.content, null)
  collect_stats = try(each.value.collect_stats, null)
  description   = try(each.value.description, null)
  enabled       = try(each.value.enabled, null)
  # interface = try(,null)
  ip_protocol      = try(each.value.ip_protocol, null)
  update_frequency = try(each.value.update_frequency, null)

  depends_on = [
    module.firewall_category,
    module.firewall_category_terraform_managed,
  ]
}

# To ensur that network groups are added after regular aliases due to potential dependencies on them.
# This is a bit of a hack and could be improved with better handling of dependencies.
module "firewall_alias_networkgroup" {
  source = "./modules/terraform-firewall-alias"

  for_each = { for alias in try(local.opnsense.firewall.alias, []) : alias.name => alias if alias.type == "networkgroup" }
  name     = each.value.name
  type     = each.value.type
  # categories = try([for cat in each.value.categories : "${module.firewall_category[cat].id}"], [])
  categories       = var.terraform_annotation && var.manage_alias_category ? concat(try([for cat in each.value.categories : "${module.firewall_category[cat].id}"], []), ["${module.firewall_category_terraform_managed[0].id}"]) : try([for cat in each.value.categories : "${module.firewall_category[cat].id}"], [])
  content          = try(each.value.content, null)
  collect_stats    = try(each.value.collect_stats, null)
  description      = try(each.value.description, null)
  enabled          = try(each.value.enabled, null)
  ip_protocol      = try(each.value.ip_protocol, null)
  update_frequency = try(each.value.update_frequency, null)

  depends_on = [
    module.firewall_category,
    module.firewall_category_terraform_managed,
    module.firewall_alias,
  ]
}