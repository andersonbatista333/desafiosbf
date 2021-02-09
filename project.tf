# project.tf - anderson.uit@gmail.com
# v.0.1
# Terraform v0.14.6
# + provider registry.terraform.io/hashicorp/google v3.56.0
#
# Aqui definimos a criação de projetos para separação de zonas de especialidade e custo. Por limitações da conta que estou utilizando, optei pelo uso de um único projeto.

## Project definition
#resource "google_project" "data-lake" {
#  name       = "Data Lake"
#  project_id = "data-lake-304301"
#}
#
#resource "google_project" "data-warehouse" {
#  name       = "Data Warehouse"
#  project_id = "data-warehouse-304301"
#}
#
#resource "google_project" "data-marts" {
#  name       = "Data Marts"
#  project_id = "data-marts-304301"
#}
