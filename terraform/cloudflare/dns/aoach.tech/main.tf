module "dns-website" {
  source = "github.com/ivanklee86/lab?ref=terraform_modules/v0.0.1//terraform_modules/cloudflare/dns"

  domain_name = "aoach.tech"
  ip          = "212.2.240.67"
  additional_records = [
    {
      type    = "A"
      name    = "whoami"
      value   = ""
      proxied = true
      ttl     = 1
    },
    {
      type    = "A"
      name    = "argocd"
      value   = ""
      proxied = true
      ttl     = 1
    },
  ]
  ttl = 1
}
