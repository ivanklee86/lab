locals {
  stacks = [
    {
      name : "dns/ivanlee.me"
      description : "DNS for ivanlee.me."
      project_root : "terraform/cloudflare/dns/ivanlee.me"
      labels : ["cloudflare", "dns"]
      contexts: ["cloudflare"]
    }
  ]
}