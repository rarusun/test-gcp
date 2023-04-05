terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.60.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.60.0"
    }
  }
}

provider "google-beta" {
  credentials = file("../${var.project_id}.json")
  project     = var.project_id
  region      = "asia-northeast1"
}

provider "google" {
  credentials = file("../${var.project_id}.json")
  project     = var.project_id
  region      = "asia-northeast1"
}
