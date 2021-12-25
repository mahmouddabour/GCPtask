# module "project-factory" {
#   source                  = "./Mod/Project"
#   random_project_id       = true
#   name                    = "simple-sample-project"
#   org_id                  = var.organization_id
#   billing_account         = var.billing_account
#   default_service_account = "deprivilege"

#   activate_api_identities = [{
#     api = "healthcare.googleapis.com"
#     roles = [
#       "roles/healthcare.serviceAgent",
#       "roles/bigquery.jobUser",
#     ]
#   }]
# }

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
}
// GKE ____________________________________________________
# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}



module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.project_id
  name                       = "gke-test-1"
  region                     = var.region
  zones                      = var.zones
  # network                    = module.vpc.network_name
  # subnetwork                 = module.subnets.network_name
  # ip_range_pods              = "us-central1-01-gke-01-pods"
  # ip_range_services          = "us-central1-01-gke-01-services"
  # http_load_balancing        = false
  horizontal_pod_autoscaling = false
  # network_policy             = false

  # node_pools = [
  #   {
  #     name                      = "default-node-pool"
  #     machine_type              = "e2-medium"
  #     node_locations            = "us-central1-b,us-central1-c"
  #     min_count                 = 1
  #     max_count                 = 100
  #     local_ssd_count           = 0
  #     disk_size_gb              = 100
  #     disk_type                 = "pd-standard"
  #     image_type                = "COS"
  #     auto_repair               = true
  #     auto_upgrade              = true
  #     service_account           = "project-service-account@<PROJECT ID>.iam.gserviceaccount.com"
  #     preemptible               = false
  #     initial_node_count        = 80
  #   },
  # ]

  # node_pools_oauth_scopes = {
  #   all = []

  #   default-node-pool = [
  #     "https://www.googleapis.com/auth/cloud-platform",
  #   ]
  # }

  # node_pools_labels = {
  #   all = {}

  #   default-node-pool = {
  #     default-node-pool = true
  #   }
  # }

  # node_pools_metadata = {
  #   all = {}

  #   default-node-pool = {
  #     node-pool-metadata-custom-value = "my-node-pool"
  #   }
  # }

  # node_pools_taints = {
  #   all = []

  #   default-node-pool = [
  #     {
  #       key    = "default-node-pool"
  #       value  = true
  #       effect = "PREFER_NO_SCHEDULE"
  #     },
  #   ]
  # }

  # node_pools_tags = {
  #   all = []

  #   default-node-pool = [
  #     "default-node-pool",
  #   ]
  # }
}
//GKE END ______________________________

