module "dns-website" {
  source = "github.com/ivanklee86/lab//terraform_modules/cloudflare/dns?ref=mailgun_dns_setup"

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
    {
      type    = "A"
      name    = "www"
      value   = ""
      proxied = true
      ttl     = 1
    },
    {
      type    = "SPF"
      name    = "mail"
      value   = "v=spf1 include:mailgun.org ~all"
      proxied = false
      ttl     = 600
    },
    {
      type    = "SPF"
      name    = "mailo._domainkey.mail"
      value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCbigVBlbGqBSP/H6u0eUIWxljxzn9RXO6+TFcj0KPjbDQ3Dhh9xYeC3g+181jQCqVeDnYXIIrpUGTZ76Ajz8ZHiDMJtFIAtHC2LwiJ9SLphteqYOi1jXz7VnjoXN2Lns4IORZeBDFuDZiMmfciCpYjJhvnrOZqXCgFonBmCHb5FQIDAQAB"
      proxied = false
      ttl     = 600
    },
    {
      type    = "MX"
      name    = "mail"
      value   = "mxa.mailgun.org"
      proxied = false
      ttl     = 600
    },
    {
      type    = "MX"
      name    = "mail"
      value   = "mxb.mailgun.org"
      proxied = false
      ttl     = 600
    },
    {
      type    = "CNAME"
      name    = "email.mail"
      value   = "mailgun.org"
      proxied = false
      ttl     = 600
    },
  ]
  ttl = 1
}
