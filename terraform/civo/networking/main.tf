resource "civo_network" "lab" {
  label = "lab"
}

resource "civo_firewall" "lab_firewall" {
  name = "lab_firewall"
  network_id = civo_network.lab.id
  create_default_rules = false
}

resource "civo_firewall_rule" "lab_firewall_rule_ingress_http" {
  firewall_id = civo_firewall.lab_firewall.id
  action = "allow"
  direction = "ingress"
  protocol = "tcp"
  start_port = "80"
  end_port = "80"
  cidr = [data.cloudflare_ip_ranges.cloudflare.cidr_blocks]
  
  label = "lab_firewall_rule_ingress_http"
  depends_on = [civo_firewall.lab_firewall]
}

resource "civo_firewall_rule" "lab_firewall_rule_ingress_https" {
  firewall_id = civo_firewall.lab_firewall.id
  action = "allow"
  direction = "ingress"
  protocol = "tcp"
  start_port = "443"
  end_port = "443"
  cidr = [data.cloudflare_ip_ranges.cloudflare.cidr_blocks]
  
  label = "lab_firewall_rule_ingress_https"
  depends_on = [civo_firewall.lab_firewall]
}

resource "civo_firewall_rule" "lab_firewall_rule_egress" {
  firewall_id = civo_firewall.lab_firewall.id
  action = "allow"
  direction = "egress"
  protocol = "tcp"
  start_port = "1"
  end_port = "65535"
  cidr = ["0.0.0.0/0"]
  
  label = "lab_firewall_rule_egress"
  depends_on = [civo_firewall.lab_firewall]
}

resource "civo_reserved_ip" "ingress" {
    name = "ingress" 
}
