module "dns-website" {
  source = "../../../../terraform_modules/cloudflare/dns"

  domain_name = "ivanlee.me"
  ip          = "3.145.179.230"
  additional_records = [
    {
      type  = "CNAME"
      name  = "lab"
      value = "ivanklee86.github.io"
    },
  ]
  proxied = true
  ttl     = 1
}
