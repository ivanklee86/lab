output "firewall_id" {
  value       = civo_firewall.lab_k8s_firewall.id
  description = "Firewall ID"
}

output "network_id" {
  value       = civo_network.lab.id
  description = "Network ID"
}

output "reserved_ip" {
  value       = civo_reserved_ip.ingress.ip
  description = "Ingress IP"
}
