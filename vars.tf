
variable "project_id" {
  description = "The ID of the project where this VPC will be created"
}

variable "network_name" {
  description = "The name of the network being created"
}
variable "subnets" {
  type        = list(map(string))
  description = "The list of subnets being created"
}
# variable "dataset_name" {
#   type        = any
# }
# variable "dataset_id" {
#   type        = any
# }

# variable "organization_id" {
#   description = "The organization id for the associated services"
# }

# variable "billing_account" {
#   description = "The ID of the billing account to associate this project with"
# }


variable "gcp_service_list" {
  description = "List of GCP service to be enabled for a project."
  type        = list
}

variable "dataset_name" {
   type        = list
 }

 variable "dataset_id" {
  type        = list
}
variable "bucket_name" {
   type        = list
 }

//GKE VARS
 variable "cluster_name_suffix" {
  description = "A suffix to append to the default cluster name"
  default     = ""
}

variable "region" {
  description = "The region to host the cluster in"
}

variable "zones" {
  type        = list(string)
  description = "The zone to host the cluster in (required if is a zonal cluster)"
}

# variable "subnetwork" {
#   description = "The subnetwork created to host the cluster in"
#   default     = var.subnets[0].subnet_name
# }

variable "ip_range_pods_name" {
  description = "The secondary ip range to use for pods"
  default     = "ip-range-pods"
}

variable "ip_range_services_name" {
  description = "The secondary ip range to use for services"
  default     = "ip-range-scv"
}

variable "compute_engine_service_account" {
  description = "Service account to associate to the nodes in the cluster"
}
variable "cluster_name" {
  description = "The name for the GKE cluster"
  default     = "vpc-cluster"
}
//___________________________