output "pod_public_ip" {
  value = runpod_pod.gpu_instance.public_ip
}

output "pod_ports" {
  value = runpod_pod.gpu_instance.ports
}

output "pod_name" {
  value = runpod_pod.gpu_instance.name
}

output "pod_id" {
  value = runpod_pod.gpu_instance.id
}

output "pod_memory_in_gb" {
  value = runpod_pod.gpu_instance.memory_in_gb
}

output "pod_min_ram_per_gpu" {
  value = runpod_pod.gpu_instance.min_ram_per_gpu
}