resource "opnsense_firewall_category" "category" {
  name  = var.name
  auto  = var.auto
  color = lookup(local.colors, var.color, var.color)
}