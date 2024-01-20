terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "1.8.0"
    }
  }
}

provider "spacelift" {}
