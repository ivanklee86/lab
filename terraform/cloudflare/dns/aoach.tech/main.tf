module "dns-website" {
  source = "../../../../terraform_modules/cloudflare/dns"

  domain_name = "aoach.tech"
  ip          = "212.2.240.67"
  additional_records = []
  proxied = true
  ttl     = 1
}
