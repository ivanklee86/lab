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

  ingress_rule {
    label      = "k8s"
    protocol   = "tcp"
    port_range = "6443"
    cidr       = [local.home_ip]
    action     = "allow"
  }

  ingress_rule {
    label    = "ping/traceroute"
    protocol = "icmp"
    cidr     = ["0.0.0.0/0"]
    action   = "allow"
  }

  ingress_rule {
    label      = "http"
    protocol   = "tcp"
    port_range = "80"
    cidr       = concat(data.cloudflare_ip_ranges.cloudflare.ipv4_cidr_blocks, formatlist(local.home_ip))
    # cidr       = ["0.0.0.0/0"]
    action = "allow"
  }

  ingress_rule {
    label      = "https"
    protocol   = "tcp"
    port_range = "443"
    cidr       = concat(data.cloudflare_ip_ranges.cloudflare.ipv4_cidr_blocks, formatlist(local.home_ip))
    # cidr       = ["0.0.0.0/0"]
    action = "allow"
  }

  ingress_rule {
    label      = "mysql"
    protocol   = "tcp"
    port_range = "3306"
    cidr       = ["0.0.0.0/0"]
    action     = "allow"
  }

  egress_rule {
    label      = "All"
    protocol   = "tcp"
    port_range = "1-65535"
    cidr       = ["0.0.0.0/0"]
    action     = "allow"
  }

  egress_rule {
    label      = "All"
    protocol   = "udp"
    port_range = "1-65535"
    cidr       = ["0.0.0.0/0"]
    action     = "allow"
  }

  egress_rule {
    label    = "Ping/Traceroute"
    protocol = "icmp"
    cidr     = ["0.0.0.0/0"]
    action   = "allow"
  }
}

resource "civo_reserved_ip" "ingress" {
  name = "ingress"
}
