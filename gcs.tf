# gcs.tf - anderson.uit@gmail.com
# v.0.1
# Terraform v0.14.6
# + provider registry.terraform.io/hashicorp/google v3.56.0
#
# Aqui definimos recursos referentes ao GCS (Google Cloud Storage). Serão criados os buckets por tipo/layer de dado e usuários/grupos para garantir a barreira de informações.


# GCS resources
resource "google_storage_bucket" "gcs-data-lake-landing" {
  name          = "desafiosbf-landing"
  project	= "desafiosbf"
  location      = local.region
  force_destroy = true
  storage_class = "STANDARD"
}

resource "google_storage_bucket" "gcs-data-lake-sensitive" {
  name          = "desafiosbf-sensitive"
  project	= "desafiosbf"
  location      = local.region
  force_destroy = true
  storage_class = "STANDARD"
}

resource "google_storage_bucket" "gcs-data-lake-work" {
  name          = "desafiosbf-work"
  project	= "desafiosbf" 
  location      = local.region
  force_destroy = true
  storage_class = "STANDARD"
}

resource "google_storage_bucket" "gcs-data-lake-backup" {
  name          = "desafiosbf-backup"
  project	= "desafiosbf"
  location      = local.region
  force_destroy = true
  storage_class = "STANDARD"
}

resource "google_storage_bucket_acl" "gcs-data-lake-landing-acl" {
  bucket = google_storage_bucket.gcs-data-lake-landing.name
  role_entity = [
#    "OWNER:anderson.uit@gmail.com",
#    "READER:anderson.uit@gmail.com",
  ]
}

resource "google_storage_bucket_acl" "gcs-data-lake-sensitive-acl" {
  bucket = google_storage_bucket.gcs-data-lake-sensitive.name
  role_entity = [
#    "OWNER:${local.unique_id}-de@gmail.com",
#    "READER:${local.unique_id}-ds@gmail.com",
  ]
}

resource "google_storage_bucket_acl" "gcs-data-lake-work-acl" {
  bucket = google_storage_bucket.gcs-data-lake-work.name
  role_entity = [
#    "OWNER:${local.unique_id}-de@gmail.com",
#    "WRITER:${local.unique_id}-ds@gmail.com",
  ]
}

resource "google_storage_bucket_acl" "gcs-data-lake-backup-acl" {
  bucket = google_storage_bucket.gcs-data-lake-backup.name
  role_entity = [
#    "OWNER:${local.unique_id}-de@gmail.com",
#    "READER:${local.unique_id}-ds@gmail.com",
  ]
}
