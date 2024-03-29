terraform {
  required_providers {
    civo = {
      source  = "civo/civo"
      version = "~> 1.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "civo" {
  region = "NYC1"
}
