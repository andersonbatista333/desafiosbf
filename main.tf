# main.tf - anderson.uit@gmail.com
# v.0.1
# Terraform v0.14.6
# + provider registry.terraform.io/hashicorp/google v3.56.0
#
# Aqui definimos o provider e algumas configs para usar o GCP como provider no Terraform.

provider "google" {
  credentials = file("../DesafioSBF-dcd64f2e328f.json")

  project = "desafiosbf"
  region  = "us-central1"
  zone    = "us-central1-c"
}
