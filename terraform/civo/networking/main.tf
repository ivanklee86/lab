locals {
  home_ip = "100.8.82.42/32"
}

data "cloudflare_ip_ranges" "cloudflare" {}

resource "civo_network" "lab" {
  label = "lab"
}

resource "civo_firewall" "lab_k8s_firewall" {
  name                 = "lab_k8s_firewall"
  network_id           = civo_network.lab.id
  create_default_rules = true
}

resource "civo_firewall" "lab_lb_firewall" {
  name                 = "lab_lb_firewall"
  network_id           = civo_network.lab.id
  create_default_rules = false

  ingress_rule {
    label      = "http"
    protocol   = "tcp"
    port_range = "80"
    cidr       = concat(data.cloudflare_ip_ranges.cloudflare.cidr_blocks, formatlist(local.home_ip))
    action     = "allow"
  }

  ingress_rule {
    label      = "https"
    protocol   = "tcp"
    port_range = "443"
    cidr       = concat(data.cloudflare_ip_ranges.cloudflare.cidr_blocks, formatlist(local.home_ip))
    action     = "allow"
  }

}

resource "civo_reserved_ip" "ingress" {
  name = "ingress"
}
