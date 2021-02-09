# gce.tf - anderson.uit@gmail.com
# v.0.1
# Terraform v0.14.6
# + provider registry.terraform.io/hashicorp/google v3.56.0
#
# Aqui criamos as VM's no GCE (Google Computing Engine) para orquestração das ingestões. Podemos plugar nesta camada o dataflow, kafka, streamsets, etc...

# Create VPC network
resource "google_compute_network" "vpc-network" {
  project = "desafiosbf" 
  name = "vpc-network"
}

# Create static external IP address
resource "google_compute_address" "orchestration-ip-static" {
  project = "desafiosbf" 
  region = local.region
  name = "${local.unique_id}-external-ip"
}

# Create orchestration instance
resource "google_compute_instance" "orchestration" {
  project      = "desafiosbf" 
  zone         = "${local.region}-a"
  name         = "orchestration"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20200701"
    }
  }
  network_interface {
    network = google_compute_network.vpc-network.name
    access_config {
        nat_ip = google_compute_address.orchestration-ip-static.address
    }
  }
  depends_on = [google_compute_address.orchestration-ip-static, google_compute_network.vpc-network]
}
