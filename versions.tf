terraform {
  required_version = ">= 1.8.0"

  required_providers {
    opnsense = {
      # version = "~> x.0"
      source = "browningluke/opnsense"
    }
    utils = {
      source  = "netascode/utils"
      version = ">= 1.0.2"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.3.0"
    }
  }
}