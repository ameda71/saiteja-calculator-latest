// Configure the Google Cloud provider with project and region
provider "google" {
  project = var.project_id  // GCP project ID
  region  = var.region      // GCP region for the cluster
}

// Create a Google Kubernetes Engine (GKE) cluster
resource "google_container_cluster" "primary" {
  name     = var.cluster_name  // Cluster name
  location = var.zone          // GKE zone

  initial_node_count = var.initial_node_count  // Number of nodes in the cluster

  node_config {
    machine_type = var.node_machine_type  // Node machine type (e.g., e2-medium)
  }
}

// Output the cluster's name and endpoint
output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

