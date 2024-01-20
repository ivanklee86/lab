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
      name : "civo/networking"
      description : "CIVO networking"
      project_root : "terraform/civo/networking"
      labels : ["civo", "cloudflare"]
      terraform_external_state_access : true
    },
    {
      name : "civo/kubernetes"
      description : "CIVO k8s"
      project_root : "terraform/civo/kubernetes"
      labels : ["civo"]
      terraform_external_state_access : false
    },
  ]
}
