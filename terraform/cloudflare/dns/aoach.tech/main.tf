module "dns-website" {
  source = "../../../../terraform_modules/cloudflare/dns"

  domain_name = "aoach.tech"
  ip          = "212.2.240.67"
  additional_records = [
    {
      type  = "A"
      name  = "whoami"
      value = ""
    },
    {
      type  = "A"
      name  = "argocd"
      value = ""
    },
  ]
  proxied = true
  ttl     = 1
}
