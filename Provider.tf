provider "google" {
  project     = var.project_id
  region      = "us-central1"
  credentials = "keys/precise-plane-336505-b88adfd9f073.json"
}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

terraform {
    required_version = ">=0.13"
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
     google = {
      source  = "hashicorp/google"
      version = ">= 3.39.0, <4.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-kubernetes-engine/v17.3.0"
  }
}

provider "random" {
  # Configuration options
}

resource "google_project_service" "project" {
# project     = var.project_id
#   service = "compute.googleapis.com"
for_each = toset(var.gcp_service_list)
  project = var.project_id
  service = each.key
  
  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}