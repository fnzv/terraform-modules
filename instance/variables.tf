variable "name" {
}

variable "network_name" {
}

variable "flavor" {
}

variable "allowed_address_pairs" {
  default = "10.2.255.0/24"
}

variable "external" {
  default = 0
}

variable "quantity" {
  default = 1
}

variable "tags" {
  type = "map"
  default = {
    role = "generic"
    status = "generic"
  }
}

variable "role" {
  default = "generic"
}

variable "status" {
  default = "generic"
}

variable "region" {
  default = "it-mil1"
}

variable "image" {
  default = "GNU/Linux Ubuntu Server 16.04 Xenial Xerus x64"
}

variable "floating_ip_pool" {
  default = "PublicNetwork"
}

variable "sec_group" {
  type = "list"
}

variable "keypair" {
}

variable "ignore_changes" {
  default = false
}
