variable "interface" {
  description = "Firewall Interface name."
  type        = list(string)
  default     = ["any"]

  validation {
    condition = alltrue([
      for i in var.interface : can(regex("^[a-zA-Z0-9]{0,32}$", i))
    ])
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`. Maximum characters: 32."
  }
}

variable "invert_interface" {
  description = "Use all but chosen interfaces. Defaults to `false`."
  type        = bool
  default     = false
}

variable "quick" {
  description = "If a packet matches a rule specifying quick, then that rule is considered the last matching rule and the specified action is taken. When a rule does not have quick enabled, the last matching rule wins. Defaults to `true`."
  type        = bool
  default     = true
}

variable "action" {
  description = "Allowed values are `pass`, `block`, `reject`. `pass` allows the traffic. `block` silently drops the traffic. `reject` drops the traffic and sends a response according to the protocol (TCP RST for TCP, ICMP unreachable for UDP and ICMP). Defaults to `pass`."
  type        = string
  default     = "pass"

  validation {
    condition     = contains(["pass", "block", "reject"], var.action)
    error_message = "Allowed values are `pass`, `block`, `reject`."
  }
}

variable "direction" {
  description = "Allowed values are `in`, `out`, `both`. Direction of the traffic. The default policy is to filter inbound traffic, which sets the policy to the interface originally receiving the traffic."
  type        = string
  default     = "in"

  validation {
    condition     = contains(["in", "out", "both"], var.direction)
    error_message = "Allowed values are `in`, `out`, `both`."
  }
}

variable "version" {
  description = "Specify IP Version.  Allowed values are `ipv4`, `ipv6`, or `both`. Defaults to `ipv4`."
  type        = string
  default     = "ipv4"

  validation {
    condition     = contains(["ipv4", "ipv6", "both"], var.version)
    error_message = "Allowed values are `ipv4`, `ipv6`, or `both`."
  }
}

variable "ip_protocol" {
  description = "Specify IP Protocol.  Defaults to `any`.  Allowed values are `any`, `icmp`, `igmp`, `ggp`, `ip`, `st`, `tcp`, `cbt`, `egp`, `igp`, `bbn-rcc`, `nvp-ii`, `pup`, `argus`, `emcon`, `xnet`, `chaos`, `udp`, `mux`, `dcn-meas`, `hmp`, `prm`, `xns-idp`, `trunk-1`, `trunk-2`, `leaf-1`, `leaf-2`, `rdp`, `irtp`, `iso-tp4`, `netblt`, `mfe-nsp`, `merit-inp`, `dccp`, `3pc`, `idpr`, `xtp`, `dsp`, `idpr-cmtp`, `tp++`, `il`, `ipv6`, `sdrp`, `ipv6-rout`, `ipv6-frag`, `idrp`, `rsvp`, `gre`, `dsr`, `bna`, `esp`, `ah`, `i-nlsp`, `swipe`, `narp`, `mobile`, `tlsp`, `skip`, `ipv6-icmp`, `ipv6-nonxt`, `ipv6-opts`, `any-host`, `cftp`, `any-local`, `sat-expak`, `kryptolan`, `rvd`, `ippc`, `any-dfs`, `sat-mon`, `visa`, `ipcv`, `cpnx`, `cphb`, `wsn`, `pvp`, `br-sat-mon`, `sun-nd`, `wb-mon`, `wb-expak`, `iso-ip`, `vmtp`, `secure-vmtp`, `vines`, `ttp`, `iptm`, `nsfnet-igp`, `dgp`, `tcf`, `eigrp`, `ospf`, `sprite-rpc`, `larp`, `mtp`, `ax.25`, `ipip`, `micp`, `scc-sp`, `etherip`, `encap`, `any-encrypt`, `gmtp`, `ifmp`, `pnni`, `pim`, `aris`, `scps`, `qnx`, `a/n`, `ipcomp`, `snp`, `compaq-peer`, `ipx-in-ip`, `vrrp`, `pgm`, `any-0hop`, `l2tp`, `ddx`, `iatp`, `stp`, `srp`, `uti`, `smp`, `sm`, `ptp`, `isis`, `fire`, `crtp`, `crudp`, `sscopmce`, `iplt`, `sps`, `pipe`, `sctp`, `fc`, `rsvp-e2e`, `mobility-header`, `udplite`, `mpls-in-ip`, `manet`, `hip`, `shim6`, `wesp`, `rohc`."
  type        = string
  default     = "any"

  validation {
    condition     = contains(["any", "icmp", "igmp", "ggp", "ip", "st", "tcp", "cbt", "egp", "igp", "bbn-rcc", "nvp-ii", "pup", "argus", "emcon", "xnet", "chaos", "udp", "mux", "dcn-meas", "hmp", "prm", "xns-idp", "trunk-1", "trunk-2", "leaf-1", "leaf-2", "rdp", "irtp", "iso-tp4", "netblt", "mfe-nsp", "merit-inp", "dccp", "3pc", "idpr", "xtp", "dsp", "idpr-cmtp", "tp++", "il", "ipv6", "sdrp", "ipv6-rout", "ipv6-frag", "idrp", "rsvp", "gre", "dsr", "bna", "esp", "ah", "i-nlsp", "swipe", "narp", "mobile", "tlsp", "skip", "ipv6-icmp", "ipv6-nonxt", "ipv6-opts", "any-host", "cftp", "any-local", "sat-expak", "kryptolan", "rvd", "ippc", "any-dfs", "sat-mon", "visa", "ipcv", "cpnx", "cphb", "wsn", "pvp", "br-sat-mon", "sun-nd", "wb-mon", "wb-expak", "iso-ip", "vmtp", "secure-vmtp", "vines", "ttp", "iptm", "nsfnet-igp", "dgp", "tcf", "eigrp", "ospf", "sprite-rpc", "larp", "mtp", "ax.25", "ipip", "micp", "scc-sp", "etherip", "encap", "any-encrypt", "gmtp", "ifmp", "pnni", "pim", "aris", "scps", "qnx", "a/n", "ipcomp", "snp", "compaq-peer", "ipx-in-ip", "vrrp", "pgm", "any-0hop", "l2tp", "ddx", "iatp", "stp", "srp", "uti", "smp", "sm", "ptp", "isis", "fire", "crtp", "crudp", "sscopmce", "iplt", "sps", "pipe", "sctp", "fc", "rsvp-e2e", "mobility-header", "udplite", "mpls-in-ip", "manet", "hip", "shim6", "wesp", "rohc"], var.ip_protocol)
    error_message = "Allowed values are `any`, `icmp`, `igmp`, `ggp`, `ip`, `st`, `tcp`, `cbt`, `egp`, `igp`, `bbn-rcc`, `nvp-ii`, `pup`, `argus`, `emcon`, `xnet`, `chaos`, `udp`, `mux`, `dcn-meas`, `hmp`, `prm`, `xns-idp`, `trunk-1`, `trunk-2`, `leaf-1`, `leaf-2`, `rdp`, `irtp`, `iso-tp4`, `netblt`, `mfe-nsp`, `merit-inp`, `dccp`, `3pc`, `idpr`, `xtp`, `dsp`, `idpr-cmtp`, `tp++`, `il`, `ipv6`, `sdrp`, `ipv6-rout`, `ipv6-frag`, `idrp`, `rsvp`, `gre`, `dsr`, `bna`, `esp`, `ah`, `i-nlsp`, `swipe`, `narp`, `mobile`, `tlsp`, `skip`, `ipv6-icmp`, `ipv6-nonxt`, `ipv6-opts`, `any-host`, `cftp`, `any-local`, `sat-expak`, `kryptolan`, `rvd`, `ippc`, `any-dfs`, `sat-mon`, `visa`, `ipcv`, `cpnx`, `cphb`, `wsn`, `pvp`, `br-sat-mon`, `sun-nd`, `wb-mon`, `wb-expak`, `iso-ip`, `vmtp`, `secure-vmtp`, `vines`, `ttp`, `iptm`, `nsfnet-igp`, `dgp`, `tcf`, `eigrp`, `ospf`, `sprite-rpc`, `larp`, `mtp`, `ax.25`, `ipip`, `micp`, `scc-sp`, `etherip`, `encap`, `any-encrypt`, `gmtp`, `ifmp`, `pnni`, `pim`, `aris`, `scps`, `qnx`, `a/n`, `ipcomp`, `snp`, `compaq-peer`, `ipx-in-ip`, `vrrp`, `pgm`, `any-0hop`, `l2tp`, `ddx`, `iatp`, `stp`, `srp`, `uti`, `smp`, `sm`, `ptp`, `isis`, `fire`, `crtp`, `crudp`, `sscopmce`, `iplt`, `sps`, `pipe`, `sctp`, `fc`, `rsvp-e2e`, `mobility-header`, `udplite`, `mpls-in-ip`, `manet`, `hip`, `shim6`, `wesp`, `rohc`."
  }
}

variable "source_networks" {
  description = "List of source networks."
  type        = list(string)
  default     = ["any"]

  validation {
    condition = alltrue([
      for i in var.source_networks : can(regex("^[a-zA-Z0-9]{0,32}$", i))
    ])
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`. Maximum characters: 32."
  }
}

variable "invert_source" {
  description = "Use all but chosen interfaces. Defaults to `false`."
  type        = bool
  default     = false
}

variable "source_port" {
  description = "Source port number or well known name.  Use `-` for ranges.  Defaults to ``."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{0,32}$", var.source_port))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `-`. Maximum characters: 32."
  }
}

variable "destination_networks" {
  description = "List of destination networks."
  type        = list(string)
  default     = ["any"]

  validation {
    condition = alltrue([
      for i in var.destination_networks : can(regex("^[a-zA-Z0-9]{0,32}$", i))
    ])
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`. Maximum characters: 32."
  }
}

variable "invert_destination" {
  description = "Use all but chosen destination networks. Defaults to `false`."
  type        = bool
  default     = false
}

variable "destination_port" {
  description = "Destination port number or well known name.  Use `-` for ranges.  Defaults to ``."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{0,32}$", var.destination_port))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `-`. Maximum characters: 32."
  }
}

variable "log" {
  description = "Enable logging for this rule. Defaults to `false`."
  type        = bool
  default     = false
}

variable "categories" {
  description = "Set of category IDs to apply. Defaults to `[]`."
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for c in var.categories : can(regex("^[a-zA-Z0-9 _.:\\'-]{0,64}$", c))
    ])
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `:`, `'`, `-`. Maximum characters: 64."
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
  description = "Enable this firewall filter rule. Defaults to `true`."
  type        = bool
  default     = true
}

# variable "internal_tagging" {

# }

variable "no_xmlrpc_sync" {
  description = "Whether to exclude this item from the HA synchronization process. An already existing item with the same UUID on the synchronization target will not be altered or deleted as long as this is active. Defaults to `false`"
  type        = bool
  default     = false
}

# variable "priority" {

# }

variable "sequence" {
  description = "Firewall rule sequence number. Defaults to `1`."
  type        = number
  default     = 1
}

# variable "source_routing" {

# }

# variable "stateful_firewall" {

# }

# variable "traffic_filtering" {

# }