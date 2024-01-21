locals {
  opentofu_version = "1.6.0"
  terraform_version = "1.5.7"
  stacks = [
    {
      name : "dns/ivanlee.me"
      description : "DNS for ivanlee.me."
      project_root : "terraform/cloudflare/dns/ivanlee.me"
      labels : ["cloudflare"]
      terraform_workflow_tool: "OPEN_TOFU"
      terraform_external_state_access : false
    },
    {
      name : "digitalocean/project"
      description : "DigitalOcean project"
      project_root : "terraform/digitalocean/project"
      labels : ["digitalocean"]
      terraform_workflow_tool: "TERRAFORM_FOSS"
      terraform_external_state_access : true
    },
  ]
}
