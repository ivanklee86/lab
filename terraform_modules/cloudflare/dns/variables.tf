# ---------------------------------------------------------------------------------------------------------------------
# Environment variables
# ---------------------------------------------------------------------------------------------------------------------

variable "domain_name" {
  description = "Domain name to modify."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# Service Variables
# ---------------------------------------------------------------------------------------------------------------------

variable "ip" {
  description = "IP address."
  type        = string
}

variable "ttl" {
  description = "TTL for DNS record."
  type        = number
  default     = 600
}

variable "additional_records" {
  description = "Additional Domain records to configure."
  type = list(
    object({
      type    = string
      name    = string
      value   = string
      proxied = bool
    })
  )
}
