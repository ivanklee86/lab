terraform {
  required_version = "~> 1.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
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
  proxied = true
}

resource "cloudflare_record" "additional_records" {
  for_each = {
    for record in var.additional_records : "${record.type}_${record.name}" => record
  }

  zone_id = data.cloudflare_zones.zone.zones[0].id
  name    = each.value.name
  value   = each.value.type == "A" ? var.ip : each.value.value
  type    = each.value.type
  proxied = each.value.proxied
  ttl     = each.value.ttl
}

# ---------------------------------------------------------------------------------------------------------------------
# CLOUDFLARE - Configuration
# ---------------------------------------------------------------------------------------------------------------------
resource "cloudflare_zone_settings_override" "test" {
  zone_id = data.cloudflare_zones.zone.zones[0].id
  settings {
    min_tls_version          = "1.3"
    tls_1_3                  = "on"
    automatic_https_rewrites = "on"
    ssl                      = "strict"
  }
}
