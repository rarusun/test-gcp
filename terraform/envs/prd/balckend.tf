terraform {
  backend "gcs" {
    bucket      = "terraform-state-112567"
    prefix      = "gcp-test/terraform/envs/prd"
  }
}