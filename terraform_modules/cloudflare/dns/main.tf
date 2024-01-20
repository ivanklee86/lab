terraform {
  required_version = "~> 1.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.0"
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CLOUDFLARE - Zones
# ---------------------------------------------------------------------------------------------------------------------

data "cloudflare_zones" "zone" {
  filter {
    name = var.domain_name
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CLOUDFLARE - Records
# ---------------------------------------------------------------------------------------------------------------------
resource "cloudflare_record" "main" {
  zone_id = data.cloudflare_zones.zone.zones[0].id
  name    = var.domain_name
  value   = var.ip
  type    = "A"
  ttl     = var.ttl
  proxied = var.proxied
}

resource "cloudflare_record" "wildcard_subdomain" {
  zone_id = data.cloudflare_zones.zone.zones[0].id
  name    = "*"
  value   = var.domain_name
  type    = "CNAME"
  ttl     = var.ttl
}

resource "cloudflare_record" "additional_records" {
  for_each = {
    for record in var.additional_records : "${record.type}_${record.name}" => record
  }

  zone_id = data.cloudflare_zones.zone.zones[0].id
  name    = each.value.name
  value   = each.value.value
  type    = each.value.type
  ttl     = 600
}
