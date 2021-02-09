# desafiosbf
Provisionando um Data Lake com Terraform - iac e desenho de arquitetura

Link para o desenho: https://drive.google.com/file/d/1mGIf3frFDgdhi1AM5rvT_otuHN4K6U8m/view?usp=sharing

Descrição dos artefatos do Terraform;

1.
# main.tf
# Definição do provider e algumas configs para usar o GCP como provider no Terraform.

2.
# variables.tf
# Definição de variáveis gerais para o projeto.

3.
# project.tf
# Criação de projetos com separação de zonas de especialidade e custo (é possível usar contas para seprar o billing). Por limitações da conta que estou utilizando, optei pelo uso de um único projeto.

4.
# gcs.tf
# Recursos referentes ao GCS (Google Cloud Storage). Serão criados os buckets por tipo/layer de dado e usuários/grupos para garantir a barreira de informações.

5.
# bq-dwh.tf
# Aqui criamos os DataSets na camada do DW no BigQuery.

6.
# gce.tf
# Criação das VM's no GCE (Google Computing Engine) para orquestração das ingestões. Podemos plugar nesta camada o dataflow, kafka, streamsets, etc...

7.
# iam.tf
# Aqui são definidos os papéis dos usuários/grupos nas camadas de consulta, armazenamento e processamento. 

8.
# gpu.tf
# Crição da VM com GPU para Machine Learning e notebooks jupyter.

9.
# start-up-script.sh
# Script para subir o docker customizado para a gpu nvidia.

-----------------------------------------------------------------------------------------------------------------------------

(base) MacBookAB3-346:Desafio_TF_DataLake_SBF andersonbatista$ terraform validate
Success! The configuration is valid.

(base) MacBookAB3-346:Desafio_TF_DataLake_SBF andersonbatista$ terraform show
# module.project_iam_binding.google_project_iam_member.project_iam_additive["default--roles/compute.admin--user:anderson.uit@gmail.com"]:
resource "google_project_iam_member" "project_iam_additive" {
    etag    = "BwW634Oadpw="
    id      = "desafiosbf/roles/compute.admin/user:anderson.uit@gmail.com"
    member  = "user:anderson.uit@gmail.com"
    project = "desafiosbf"
    role    = "roles/compute.admin"
}

# module.project_iam_binding.google_project_iam_member.project_iam_additive["default--roles/storage.admin--user:anderson.uit@gmail.com"]:
resource "google_project_iam_member" "project_iam_additive" {
    etag    = "BwW634Oadpw="
    id      = "desafiosbf/roles/storage.admin/user:anderson.uit@gmail.com"
    member  = "user:anderson.uit@gmail.com"
    project = "desafiosbf"
    role    = "roles/storage.admin"
}

# module.project_iam_binding.google_project_iam_member.project_iam_additive["default--roles/bigquery.admin--user:anderson.uit@gmail.com"]:
resource "google_project_iam_member" "project_iam_additive" {
    etag    = "BwW634Oadpw="
    id      = "desafiosbf/roles/bigquery.admin/user:anderson.uit@gmail.com"
    member  = "user:anderson.uit@gmail.com"
    project = "desafiosbf"
    role    = "roles/bigquery.admin"
}


# google_bigquery_dataset.dwh-bq-system1:
resource "google_bigquery_dataset" "dwh-bq-system1" {
    creation_time                   = 1612844030137
    dataset_id                      = "SYSTEM1"
    default_partition_expiration_ms = 0
    default_table_expiration_ms     = 0
    delete_contents_on_destroy      = false
    etag                            = "QMoefVbv1qw9LIlErM18uQ=="
    id                              = "projects/desafiosbf/datasets/SYSTEM1"
    labels                          = {}
    last_modified_time              = 1612844030137
    location                        = "us-central1"
    project                         = "desafiosbf"
    self_link                       = "https://bigquery.googleapis.com/bigquery/v2/projects/desafiosbf/datasets/SYSTEM1"

    access {
        role          = "OWNER"
        user_by_email = "anderson.uit@gmail.com"
    }
    access {
        role          = "READER"
        user_by_email = "anderson.uit@gmail.com"
    }
    access {
        role          = "WRITER"
        user_by_email = "anderson.uit@gmail.com"
    }
}

# google_bigquery_dataset.dwh-bq-system2:
resource "google_bigquery_dataset" "dwh-bq-system2" {
    creation_time                   = 1612844030729
    dataset_id                      = "SYSTEM2"
    default_partition_expiration_ms = 0
    default_table_expiration_ms     = 0
    delete_contents_on_destroy      = false
    etag                            = "AvglxEo4XyU0957dhKjF2A=="
    id                              = "projects/desafiosbf/datasets/SYSTEM2"
    labels                          = {}
    last_modified_time              = 1612844030729
    location                        = "us-central1"
    project                         = "desafiosbf"
    self_link                       = "https://bigquery.googleapis.com/bigquery/v2/projects/desafiosbf/datasets/SYSTEM2"

    access {
        role          = "OWNER"
        user_by_email = "anderson.uit@gmail.com"
    }
    access {
        role          = "READER"
        user_by_email = "anderson.uit@gmail.com"
    }
    access {
        role          = "WRITER"
        user_by_email = "anderson.uit@gmail.com"
    }
}

# google_bigquery_dataset.dwh-bq-system3:
resource "google_bigquery_dataset" "dwh-bq-system3" {
    creation_time                   = 1612844030734
    dataset_id                      = "SYSTEM3"
    default_partition_expiration_ms = 0
    default_table_expiration_ms     = 0
    delete_contents_on_destroy      = false
    etag                            = "Ye/1mg+6umkpmjYr/tuF+w=="
    id                              = "projects/desafiosbf/datasets/SYSTEM3"
    labels                          = {}
    last_modified_time              = 1612844030734
    location                        = "us-central1"
    project                         = "desafiosbf"
    self_link                       = "https://bigquery.googleapis.com/bigquery/v2/projects/desafiosbf/datasets/SYSTEM3"

    access {
        role          = "OWNER"
        user_by_email = "anderson.uit@gmail.com"
    }
    access {
        role          = "READER"
        user_by_email = "anderson.uit@gmail.com"
    }
    access {
        role          = "WRITER"
        user_by_email = "anderson.uit@gmail.com"
    }
}

# google_compute_address.orchestration-ip-static:
resource "google_compute_address" "orchestration-ip-static" {
    address            = "34.121.63.135"
    address_type       = "EXTERNAL"
    creation_timestamp = "2021-02-08T20:13:50.431-08:00"
    id                 = "projects/desafiosbf/regions/us-central1/addresses/cloud-iac-external-ip"
    name               = "cloud-iac-external-ip"
    network_tier       = "PREMIUM"
    project            = "desafiosbf"
    region             = "us-central1"
    self_link          = "https://www.googleapis.com/compute/v1/projects/desafiosbf/regions/us-central1/addresses/cloud-iac-external-ip"
    users              = [
        "https://www.googleapis.com/compute/v1/projects/desafiosbf/zones/us-central1-a/instances/orchestration",
    ]
}

# google_compute_instance.orchestration:
resource "google_compute_instance" "orchestration" {
    can_ip_forward       = false
    cpu_platform         = "AMD Rome"
    current_status       = "RUNNING"
    deletion_protection  = false
    enable_display       = false
    guest_accelerator    = []
    id                   = "projects/desafiosbf/zones/us-central1-a/instances/orchestration"
    instance_id          = "5646518018903093982"
    label_fingerprint    = "42WmSpB8rSM="
    labels               = {}
    machine_type         = "e2-micro"
    metadata             = {}
    metadata_fingerprint = "pqpGL5OHfbo="
    name                 = "orchestration"
    project              = "desafiosbf"
    resource_policies    = []
    self_link            = "https://www.googleapis.com/compute/v1/projects/desafiosbf/zones/us-central1-a/instances/orchestration"
    tags                 = []
    tags_fingerprint     = "42WmSpB8rSM="
    zone                 = "us-central1-a"

    boot_disk {
        auto_delete = true
        device_name = "persistent-disk-0"
        mode        = "READ_WRITE"
        source      = "https://www.googleapis.com/compute/v1/projects/desafiosbf/zones/us-central1-a/disks/orchestration"

        initialize_params {
            image  = "https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20200701"
            labels = {}
            size   = 10
            type   = "pd-standard"
        }
    }

    network_interface {
        name               = "nic0"
        network            = "https://www.googleapis.com/compute/v1/projects/desafiosbf/global/networks/vpc-network"
        network_ip         = "10.128.0.2"
        subnetwork         = "https://www.googleapis.com/compute/v1/projects/desafiosbf/regions/us-central1/subnetworks/vpc-network"
        subnetwork_project = "desafiosbf"

        access_config {
            nat_ip       = "34.121.63.135"
            network_tier = "PREMIUM"
        }
    }

    scheduling {
        automatic_restart   = true
        on_host_maintenance = "MIGRATE"
        preemptible         = false
    }

    shielded_instance_config {
        enable_integrity_monitoring = true
        enable_secure_boot          = false
        enable_vtpm                 = true
    }
}

# google_compute_network.vpc-network:
resource "google_compute_network" "vpc-network" {
    auto_create_subnetworks         = true
    delete_default_routes_on_create = false
    id                              = "projects/desafiosbf/global/networks/vpc-network"
    mtu                             = 0
    name                            = "vpc-network"
    project                         = "desafiosbf"
    routing_mode                    = "REGIONAL"
    self_link                       = "https://www.googleapis.com/compute/v1/projects/desafiosbf/global/networks/vpc-network"
}

# google_storage_bucket.gcs-data-lake-backup:
resource "google_storage_bucket" "gcs-data-lake-backup" {
    bucket_policy_only          = false
    default_event_based_hold    = false
    force_destroy               = true
    id                          = "desafiosbf-backup"
    labels                      = {}
    location                    = "US-CENTRAL1"
    name                        = "desafiosbf-backup"
    project                     = "desafiosbf"
    requester_pays              = false
    self_link                   = "https://www.googleapis.com/storage/v1/b/desafiosbf-backup"
    storage_class               = "STANDARD"
    uniform_bucket_level_access = false
    url                         = "gs://desafiosbf-backup"
}

# google_storage_bucket.gcs-data-lake-landing:
resource "google_storage_bucket" "gcs-data-lake-landing" {
    bucket_policy_only          = false
    default_event_based_hold    = false
    force_destroy               = true
    id                          = "desafiosbf-landing"
    labels                      = {}
    location                    = "US-CENTRAL1"
    name                        = "desafiosbf-landing"
    project                     = "desafiosbf"
    requester_pays              = false
    self_link                   = "https://www.googleapis.com/storage/v1/b/desafiosbf-landing"
    storage_class               = "STANDARD"
    uniform_bucket_level_access = false
    url                         = "gs://desafiosbf-landing"
}

# google_storage_bucket.gcs-data-lake-sensitive:
resource "google_storage_bucket" "gcs-data-lake-sensitive" {
    bucket_policy_only          = false
    default_event_based_hold    = false
    force_destroy               = true
    id                          = "desafiosbf-sensitive"
    labels                      = {}
    location                    = "US-CENTRAL1"
    name                        = "desafiosbf-sensitive"
    project                     = "desafiosbf"
    requester_pays              = false
    self_link                   = "https://www.googleapis.com/storage/v1/b/desafiosbf-sensitive"
    storage_class               = "STANDARD"
    uniform_bucket_level_access = false
    url                         = "gs://desafiosbf-sensitive"
}

# google_storage_bucket.gcs-data-lake-work:
resource "google_storage_bucket" "gcs-data-lake-work" {
    bucket_policy_only          = false
    default_event_based_hold    = false
    force_destroy               = true
    id                          = "desafiosbf-work"
    labels                      = {}
    location                    = "US-CENTRAL1"
    name                        = "desafiosbf-work"
    project                     = "desafiosbf"
    requester_pays              = false
    self_link                   = "https://www.googleapis.com/storage/v1/b/desafiosbf-work"
    storage_class               = "STANDARD"
    uniform_bucket_level_access = false
    url                         = "gs://desafiosbf-work"
}

# google_storage_bucket_acl.gcs-data-lake-backup-acl:
resource "google_storage_bucket_acl" "gcs-data-lake-backup-acl" {
    bucket      = "desafiosbf-backup"
    id          = "desafiosbf-backup-acl"
    role_entity = []
}

# google_storage_bucket_acl.gcs-data-lake-landing-acl:
resource "google_storage_bucket_acl" "gcs-data-lake-landing-acl" {
    bucket      = "desafiosbf-landing"
    id          = "desafiosbf-landing-acl"
    role_entity = []
}

# google_storage_bucket_acl.gcs-data-lake-sensitive-acl:
resource "google_storage_bucket_acl" "gcs-data-lake-sensitive-acl" {
    bucket      = "desafiosbf-sensitive"
    id          = "desafiosbf-sensitive-acl"
    role_entity = []
}

# google_storage_bucket_acl.gcs-data-lake-work-acl:
resource "google_storage_bucket_acl" "gcs-data-lake-work-acl" {
    bucket      = "desafiosbf-work"
    id          = "desafiosbf-work-acl"
    role_entity = []
}
(base) MacBookAB3-346:Desafio_TF_DataLake_SBF andersonbatista$

-----------------------------------------------------------------------------------------------------------------------------




