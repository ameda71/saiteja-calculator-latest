// Define the GCP project ID variable
variable "project_id" {
  description = "The GCP project ID"  // GCP Project ID
  type        = string
}

// Define the region for the GKE cluster
variable "region" {
  description = "The region for the GKE cluster"  // GKE region
  type        = string
  default     = "us-central1"  // Default region
}

// Define the zone for the GKE cluster
variable "zone" {
  description = "The zone for the GKE cluster"  // GKE zone
  type        = string
  default     = "us-central1-a"  // Default zone
}

// Define the name of the GKE cluster
variable "cluster_name" {
  description = "The name of the GKE cluster"  // Cluster name
  type        = string
  default     = "my-gke-cluster"  // Default name for the cluster
}

// Define the initial number of nodes in the cluster
variable "initial_node_count" {
  description = "The initial number of nodes in the cluster"  // Number of nodes
  type        = number
  default     = 3  // Default number of nodes
}

// Define the machine type for the GKE nodes
variable "node_machine_type" {
  description = "The machine type for the nodes in the cluster"  // Node machine type
  type        = string
  default     = "e2-medium"  // Default machine type
}

