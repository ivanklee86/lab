module "dns-website" {
  source = "../../../../terraform_modules/cloudflare/dns"

  domain_name = "ivanlee.me"
  ip          = "212.2.240.67"
  additional_records = [
    {
      type    = "CNAME"
      name    = "lab"
      value   = "ivanklee86.github.io"
      proxied = false
      ttl     = 600
    },
  ]
  ttl = 1
}
