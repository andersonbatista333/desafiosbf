# bq-dwh.tf - anderson.uit@gmail.com
# v.0.1
# Terraform v0.14.6
# + provider registry.terraform.io/hashicorp/google v3.56.0
#
# Aqui criamos os DataSets na camada do DW no BigQuery.

# Data Warehouse
resource "google_bigquery_dataset" "dwh-bq-system1" {
  dataset_id                  = "SYSTEM1"
  description                 = ""
  project = "desafiosbf" 
  location                    = local.region
  # Order of access matters
  # WRITER -> OWNER -> READER
  access {
    role          = "WRITER"
    user_by_email = "anderson.uit@gmail.com"
  }
  access {
    role           = "OWNER"
    user_by_email = "anderson.uit@gmail.com"
  }
  access {
    role           = "READER"
    user_by_email = "anderson.uit@gmail.com"
  }
}

resource "google_bigquery_dataset" "dwh-bq-system2" {
  dataset_id                  = "SYSTEM2"
  description                 = ""
  project = "desafiosbf" 
  location                    = local.region
  access {
    role          = "WRITER"
    user_by_email = "anderson.uit@gmail.com"
  }
  access {
    role           = "OWNER"
    user_by_email = "anderson.uit@gmail.com"
  }
  access {
    role           = "READER"
    user_by_email = "anderson.uit@gmail.com"
  }
}

resource "google_bigquery_dataset" "dwh-bq-system3" {
  dataset_id                  = "SYSTEM3"
  description                 = ""
  project = "desafiosbf" 
  location                    = local.region
  access {
    role          = "WRITER"
    user_by_email = "anderson.uit@gmail.com"
  }
  access {
    role           = "OWNER"
    user_by_email = "anderson.uit@gmail.com"
  }
  access {
    role           = "READER"
    user_by_email = "anderson.uit@gmail.com"
  }
}
