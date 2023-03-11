provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket = "my-project-id-tfstate"
    prefix = "terraform/state"
  }
} 