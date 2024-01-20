resource "civo_network" "lab" {
  label = "lab"
}

resource "civo_firewall" "lab_firewall" {
  name = "lab_firewall"
  network_id = civo_network.lab.id
  create_default_rules = false
  
  ingress_rule {
    label      = "k8s"
    protocol   = "tcp"
    port_range = "6443"
    cidr       = ["100.8.82.42/32"]
    action     = "allow"
  }

  egress_rule {
    label      = "all"
    protocol   = "tcp"
    port_range = "1-65535"
    cidr       = ["0.0.0.0/0"]
    action     = "allow"
  }

}
