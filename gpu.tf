# gpu.tf - anderson.uit@gmail.com
# v.0.1
# Terraform v0.14.6
# + provider registry.terraform.io/hashicorp/google v3.56.0
#
# Aqui criamos a VM com GPU para Machine Learning e notebooks jupyter.


#resource "google_compute_instance" "gpu-vm" {
#  count        = 1
#  name         = "gpu-vm"
#  machine_type = "n1-standard-4"
## zone         = "var.region" // Call it from variable "region"
#
#  tags = ["web", "gpu"]
#
# boot_disk {
#    initialize_params {
#      image = "ubuntu-os-cloud/ubuntu-1604-lts"
#      size = 50
#    }
#  }
#
#  network_interface {
#    network = "desafiosbf" 
#  }
#
#
##  guest_accelerator{
##    type = "nvidia-tesla-k80" // Type of GPU attahced
##    count = 1 // Num of GPU attached
##  }
#
#  scheduling{
#    on_host_maintenance = "TERMINATE" // Need to terminate GPU on maintenance
#  }
#
#  metadata_startup_script = file("start-up-script.sh") // Add the startup script locally
#}

