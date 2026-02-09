variable "name" {
  description = "Firewall Alias name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z_][a-zA-Z0-9_]{0,31}$", var.name))
    error_message = "The name must start with a letter or single underscore, be less than 32 characters and only consist of alphanumeric characters or underscores."
  }
}

variable "description" {
  description = "Firewall Alias description."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^[a-zA-Z0-9\\\\!#$%()*,-./:;@ _{|}~?&+]{0,128}$", var.description))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `\\`, `!`, `#`, `$`, `%`, `(`, `)`, `*`, `,`, `-`, `.`, `/`, `:`, `;`, `@`, ` `, `_`, `{`, `|`, }`, `~`, `?`, `&`, `+`. Maximum characters: 128."
  }
}

variable "enabled" {
  description = "Enable this firewall alias. Deafults to `true`."
  type        = bool
  default     = true
}

variable "type" {
  description = "Firewall Alias type."
  type        = string

  validation {
    condition     = contains(["host", "network", "port", "url", "urltable", "geoip", "networkgroup", "mac", "asn", "dynipv6host", "authgroup", "internal", "external"], var.type)
    error_message = "`Alias Type`: Allowed values are `host`, `network`, `port`, `url`, `urltable`, `geoip`, `networkgroup`, `mac`, `asn`, `dynipv6host`, `authgroup`, `internal`, `external`"
  }
}

variable "categories" {
  description = "Set of category IDs to apply. Defaults to `[]`."
  type        = list(string)
  default     = []
}

variable "content" {
  description = "The content of the alias. Enter ISO 3166-1 country codes when `type = \"geoip\"` (e.g. `[\"CA\", \"FR\"]`). Enter `__<int>_network`, or alias when `type = \"networkgroup\"` (e.g. `[\"__wan_network\", \"otheralias\"]`). Enter OpenVPN group when `type = \"authgroup\"` (e.g. `[\"admins\"]`). Set to `[]` when `type = \"external\"`. Defaults to `[]`."
  type        = any
}

variable "interface" {
  description = "Choose on which interface this alias applies. Only applies (and must be set) when `type = \"dynipv6host\"`. Defaults to `\"\"`."
  type        = string
  default     = ""
}

variable "ip_protocol" {
  description = "Select the Internet Protocol version this alias applies to. Available values: `IPv4`, `IPv6`. Only applies when `type = \"asn\"`, `type = \"geoip\"`, or `type = \"external\"`. Defaults to `[\"IPv4\"]`."
  type        = list(string)
  default     = ["ipv4"]

  # validation {
  #   condition     = try(contains(["ipv4", "ipv6"], var.ip_protocol), false)
  #   error_message = "Firewall Alias `ip_protocol`: Allowed values are `ipv4` and `ipv6`."
  # }
  # validation {
  #   condition = var.ip_protocol == null || alltrue([
  #     for prot in var.ip_protocol : contains(["ipv4", "ipv6"], prot)
  #   ])
  #   error_message = "`ip_protocol`: Allowed Values are `ipv4`, `ipv6`, or `null`"
  # }
}

variable "collect_stats" {
  description = "Whether to maintain a set of counters for each table entry."
  type        = bool
  default     = false
}

variable "update_frequency" {
  description = "The frequency that the list will be refreshed, in days (e.g. for 30 hours, enter `1.25`). Only applies (and must be set) when `type = \"urltable\"`. Defaults to `-1`."
  type        = number
  default     = -1
}
