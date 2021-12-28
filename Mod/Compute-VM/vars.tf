

variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "VMnameprefix" {
  description = "vm name prefix"
  default     = "Private so far"
}

variable "tags" {
  description = "tags"
}

variable "zone" {
  type        = list(string)
  description = "The zone to host the cluster in (required if is a zonal cluster)"
}

variable "network" {
  description = "The VPC network to host the cluster in"
}

variable "subnetwork" {
  description = "The subnetwork to host the cluster in"
}

variable "machine_type" {
  description = "machine type"
}
variable "size" {
  description = "VM size"
}
variable "type" {
  description = "VM boot disk type"
}
variable "image" {
  description = "VM boot disk image"
}
variable "metadata_startup_script" {
  description = "startup script"
}

variable "compute_engine_service_account" {
  description = "Service account to associate to the nodes in the cluster"
}
  