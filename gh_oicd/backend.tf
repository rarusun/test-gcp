terraform {
  backend "gcs" {
    credentials = "../service-account-112567.json"
    bucket      = "terraform-state-112567"
    prefix      = "gcp-test/gh_oicd"
  }
}