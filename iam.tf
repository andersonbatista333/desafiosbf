# iam.tf - anderson.uit@gmail.com
# v.0.1
# Terraform v0.14.6
# + provider registry.terraform.io/hashicorp/google v3.56.0
#
# Aqui são definidos os papéis dos usuários/grupos nas camadas de consulta, armazenamento e processamento. 

# Sample IAM permission
module "project_iam_binding" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam/"
  projects = ["desafiosbf"]
  mode     = "additive"
  bindings = {
    # Bigquery 
    #"roles/bigquery.admin" = ["user:${local.unique_id}-de@gmail.com"]
    "roles/bigquery.admin" = ["user:anderson.uit@gmail.com"]
    # GCS
    #"roles/storage.admin" = ["user:${local.unique_id}-de@gmail.com"]
    "roles/storage.admin" = ["user:anderson.uit@gmail.com"]
    # Compute
    #"roles/compute.admin" = ["user:${local.unique_id}-de@gmail.com"]
    "roles/compute.admin" = ["user:anderson.uit@gmail.com"]
  }
}
