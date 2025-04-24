// Configure the Google Cloud provider with project and region
provider "google" {
  project = var.project_id
  region  = var.region
}

// Create a Google Kubernetes Engine (GKE) cluster
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.zone

  initial_node_count = var.initial_node_count

  node_config {
    machine_type = var.node_machine_type
    disk_size_gb = 20
  }
}

// Output the cluster's name and endpoint
output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}
