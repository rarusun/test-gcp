terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.60.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = "asia-northeast1"
}
