module "dns-website" {
  source = "github.com/ivanklee86/lab//terraform_modules/cloudflare/dns?ref=mailgun_dns_setup"

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
