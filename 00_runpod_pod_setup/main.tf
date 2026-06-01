terraform {
  required_providers {
    runpod = {
      source = "decentralized-infrastructure/runpod"
    }
  }
}

provider "runpod" {
  api_key = var.runpod_api_key
}

# Create a network volume
resource "runpod_network_volume" "storage" {
  name           = "faiq-storage"
  size           = 200
  data_center_id = "US-CA-2"
}

# Create a GPU pod
resource "runpod_pod" "gpu_instance" {
  name              = "faiq-gpu-pod"
  image_name        = "runpod/pytorch:1.0.2-cu1281-torch280-ubuntu2404"
  gpu_type_ids      = ["NVIDIA GeForce RTX 4090", "NVIDIA A40", "NVIDIA GeForce RTX 3090 Ti", "Tesla T4"]
  # data_center_ids   = ["US-CA-2", "US-TX-3"]

  gpu_count            = 1
  cloud_type           = "SECURE" # COMMUNITY is free, SECURE is paid
  support_public_ip    = true
  network_volume_id    = runpod_network_volume.storage.id

  volume_in_gb         = 200
  container_disk_in_gb = 200

  env = {
  }

  ports = ["16352/tcp", "22/tcp"]
}
