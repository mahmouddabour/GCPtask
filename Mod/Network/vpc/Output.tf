# output "vpcmainid" {
#   value = google_compute_network.vpcmain.network_id
# }

output "network" {
  value       = google_compute_network.network
  description = "The VPC resource being created"
}

output "network_name" {
  value       = google_compute_network.network.name
  description = "The name of the VPC being created"
}

output "network_id" {
  value       = google_compute_network.network.id
  description = "The ID of the VPC being created"
}
