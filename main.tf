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

// GKE ____________________________________________________
# google_client_config and kubernetes provider must be explicitly specified like the following.
# data "google_client_config" "default" {}



# module "gke" {
#   source                     = "./Mod/Compute-GKE"
#   project_id                 = var.project_id
#   name                       = "gke111111111111"
#   regional                   = false
#   region                     = var.region
#   zones                      = var.zones
#   network                    = module.vpc.network_name
#   subnetwork                 = var.subnetwork
#   ip_range_pods              = var.ip_range_pods
#   ip_range_services          = var.ip_range_services
  # http_load_balancing        = false
#  horizontal_pod_autoscaling = true
  # network_policy             = false
# service_account         = var.compute_engine_service_account
  #  node_pools = [
  #  {
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
  #     service_account           = var.compute_engine_service_account
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
# }


# provider "google" {
#   version = "~> 3.42.0"
#   region  = var.region
# }



# provider "kubernetes" {
#   host                   = "https://${module.gke.endpoint}"
#   token                  = data.google_client_config.default.access_token
#   cluster_ca_certificate = base64decode(module.gke.ca_certificate)
# }

# data "google_compute_subnetwork" "subnetwork" {
#   name    = module.subnets
#   project = var.project_id
#   region  = var.region
#    secondary_ip_range {
#     range_name    = "services-range"
#     ip_cidr_range = "192.168.1.0/24"
#   }

#   secondary_ip_range {
#     range_name    = "pod-ranges"
#     ip_cidr_range = "192.168.64.0/22"
#   }
# }

# module "gke" {
#   source                  = "./Mod/private-cluster"
#   project_id              = var.project_id
#   name                    = "${local.cluster_type}-cluster${var.cluster_name_suffix}"
#   regional                = false
#   region                  = var.region
#   zones                   = var.zones
#   network                 = module.vpc.network_name
#   subnetwork              = "subnet-01"
#   ip_range_pods           = var.ip_range_pods
#   ip_range_services       = var.ip_range_services
#   create_service_account  = false
#   service_account         = var.compute_engine_service_account
#   enable_private_endpoint = true
#   enable_private_nodes    = true
#   # master_ipv4_cidr_block  = "172.16.0.0/28"

#   # master_authorized_networks = [
#   #   {
#   #     cidr_block   = data.google_compute_subnetwork.subnetwork.ip_cidr_range
#   #     display_name = "VPC"
#   #   },
#   # ]
# }

# module "gcp-network" {
#   source       = "./Mod/Network/subnets"
#  // version      = "~> 3.1"
#   project_id   = var.project_id
#   network_name = module.vpc.network_name

#   subnets = [
#     {
#       subnet_name           = var.subnetwork
#       subnet_ip             = "10.0.0.0/17"
#       subnet_region         = var.region
#       subnet_private_access = "true"
#     },
#   ]

#   secondary_ranges = {
#     (var.subnetwork) = [
#       {
#         range_name    = var.ip_range_pods_name
#         ip_cidr_range = "192.168.0.0/18"
#       },
#       {
#         range_name    = var.ip_range_services_name
#         ip_cidr_range = "192.168.64.0/18"
#       },
#     ]
#   }
# }

locals {
  cluster_type = "simple-zonal-private"
}
data "google_client_config" "default" {}
data "google_compute_subnetwork" "subnetwork" {
  name       = var.subnetwork
  project    = var.project_id
  region     = var.region
  depends_on = [module.subnets]
 
}

module "gke" {
  source     = "./Mod/private-cluster/"
  project_id = var.project_id
  name       = var.cluster_name
  regional   = false
  region     = var.region
  zones      = slice(var.zones, 0, 1)

  network                 = module.vpc.network_name
  subnetwork              = var.subnetwork
  ip_range_pods           = var.ip_range_pods_name
  ip_range_services       = var.ip_range_services_name
  create_service_account  = true
  enable_private_endpoint = true
  enable_private_nodes    = true
  master_ipv4_cidr_block  = "172.16.0.0/28"

  master_authorized_networks = [
    {
      cidr_block   = "172.16.0.0/28"
      display_name = "VPC"
    }
  ]

node_pools = [
    {
      name                      = "default-node-pool"
      machine_type              = "e2-standard-2"
     // node_locations            = "us-central1-b,us-central1-c"
      min_count                 = 4
      max_count                 = 100
      local_ssd_count           = 0
      disk_size_gb              = 100
      disk_type                 = "pd-standard"
      image_type                = "COS"
      auto_repair               = true
      auto_upgrade              = true
      service_account           = var.compute_engine_service_account
      preemptible               = false
      initial_node_count        = 1
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
 
  }

 //depends_on = [google_project_service.project]
//depends_on = [module.subnets]




}








//GKE END ______________________________

