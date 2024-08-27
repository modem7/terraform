variable "virtual_environment_endpoint" {
  type        = string
  description = "The endpoint for the Proxmox Virtual Environment API (example: https://host:port)"
}

variable "virtual_environment_api_token" {
  type        = string
  description = "The API token for the Proxmox Virtual Environment API"
}

variable "virtual_environment_ssh_username" {
  type        = string
  description = "The username for the Proxmox Virtual Environment API"
}

variable "virtual_environment_nic" {
  type        = string
  description = "The network bridge name (example: vmbr0)"
}

variable "virtual_environment_node" {
  type        = string
  description = "The node name (example: proxmox)"
}

variable "virtual_environment_datastore_id" {
  type        = string
  description = "The datastore ID (example: proxmox)"
}

variable "ubuntu_cloud_image_img_url" {
  type        = string
  description = "The URL for the Ubuntu 22.04 image"
  default     = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}
