resource "google_compute_instance" "default2" {
  name         = "${var.VMnameprefix}-${random_id.instance_id.hex}"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
      size = var.size
      type = var.storagetype
    }
  }
   metadata_startup_script = var.metadata_startup_script

  network_interface {
    network = var.network
    subnetwork = google_compute_subnetwork.network-with-private-secondary-ip-ranges.id
  }

  // Apply the firewall rule to allow external IPs to access this instance
  tags = var.tags
}