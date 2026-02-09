resource "opnsense_firewall_alias" "alias" {
  name        = var.name
  type        = var.type
  categories  = var.categories
  content     = var.content
  description = var.description
  enabled     = var.enabled
  stats       = var.collect_stats
  interface   = var.type == "dynipv6host" ? var.interface : null
  ip_protocol = contains(["asn", "geoip", "external"], var.type) ? var.ip_protocol : null
  update_freq = var.type == "urltable" ? var.update_frequency : null
}