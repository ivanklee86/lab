output "firewall_id" {
  value       = civo_firewall.lab_firewall.id
  description = "Firewall ID"
}

output "reserved_ip" {
  value       = civo_reserved_ip.ingress.ip
  description = "Ingress IP"
}
