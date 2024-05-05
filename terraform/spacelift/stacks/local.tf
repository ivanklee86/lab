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
      name : "dns/aoach.tech"
      description : "DNS for aoach.tech."
      project_root : "terraform/cloudflare/dns/aoach.tech"
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
      name : "civo/databases/mysql"
      description : "CIVO MySQL database"
      project_root : "terraform/civo/databases/mysql"
      labels : ["civo"]
      terraform_external_state_access : false
    },
    {
      name : "elephentsql/postgres"
      description : "ElephantSQL postgres database"
      project_root : "terraform/elephantsql"
      labels : ["elephantsql"]
      terraform_external_state_access : false
    },
  ]
}
