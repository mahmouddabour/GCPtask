module "vpc" {
  source                                 = "./Mod/Network/vpc"
  network_name                           = var.network_name
  //auto_create_subnetworks                = var.auto_create_subnetworks
  //routing_mode                           = var.routing_mode
  project_id                             = var.project_id
  //description                            = var.description
  //shared_vpc_host                        = var.shared_vpc_host
  //delete_default_internet_gateway_routes = var.delete_default_internet_gateway_routes
  //mtu                                    = var.mtu
}

module "subnets" {
  source           = "./Mod/Network/subnets"
  project_id       = var.project_id
  network_name     = module.vpc.network_name
  subnets          = var.subnets  
  //secondary_ranges = var.secondary_ranges
   secondary_ranges = {
    (var.subnetwork) = [
      {
        range_name    = var.ip_range_pods_name
        ip_cidr_range = "192.168.0.0/18"
      },
      {
        range_name    = var.ip_range_services_name
        ip_cidr_range = "192.168.64.0/18"
      },
    ]
  }

  depends_on = [google_project_service.project]
}

module "bigquery" {
  source  = "./Mod/dataset"
  //version = "~> 4.4"

 // dataset_id                  = "foo"
 // dataset_name                = var.dataset_name
 // description                 = "some description"
  project_id                  = var.project_id

for_each = toset(var.dataset_name)
  dataset_name = each.key
  dataset_id = each.key




depends_on = [google_project_service.project]
}

module "bucket" {
  source  = "./Mod/storage"
  //version = "~> 1.3"
project_id = var.project_id
  location   = "us-central1"
for_each = toset(var.bucket_name)
  name   = "example-bucket-${each.key}-${var.project_id}"
  
  # iam_members = [{
  #   role   = "roles/storage.objectViewer"
  #   member = "user:example-user@example.com"
  # }]
  depends_on = [google_project_service.project]
}

module "VM" {
  source = "./Mod/Compute-VM"
  
  
}