resource "elephantsql_instance" "postgres" {
  name   = "postgres"
  plan   = "turtle"
  region = "amazon-web-services::us-east-1"
}
