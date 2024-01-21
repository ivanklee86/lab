locals {
  stacks = [
    {
      name : "dns/ivanlee.me"
      description : "DNS for ivanlee.me."
      project_root : "terraform/cloudflare/dns/ivanlee.me"
      labels : ["cloudflare"]
      terraform_external_state_access : false
    },
    {
      name : "digitalocean/project"
      description : "DigitalOcean project"
      project_root : "terraform/digitalocean/project"
      labels : ["digitalocean"]
      terraform_external_state_access : true
    },
  ]
}
