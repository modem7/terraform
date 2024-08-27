variable "virtual_environment_endpoint" {
  type        = string
  description = "The endpoint for the Proxmox Virtual Environment API (example: https://host:port)"
}

variable "virtual_environment_api_token_id" {
  type        = string
  sensitive   = true
  description = "The API token for the Proxmox Virtual Environment API"
}

variable "virtual_environment_api_token_secret" {
  type        = string
  sensitive   = true
  description = "The API token secret for the Proxmox Virtual Environment API"
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

variable "virtual_machine_balloon" {
  type        = string
  description = "The minimum amount of memory to allocate to the VM in Megabytes, when Automatic Memory Allocation is desired"
}

variable "virtual_machine_bios" {
  type        = string
  description = "The BIOS to use, options are seabios or ovmf for UEFI."
}

variable "virtual_machine_cores" {
  type        = string
  description = "The number of CPU cores per CPU socket to allocate to the VM."
}

variable "virtual_machine_cpu" {
  type        = string
  description = "The type of CPU to emulate in the Guest"
}

variable "virtual_machine_memory" {
  type        = string
  description = "The amount of memory to allocate to the VM in Megabytes."
}

variable "virtual_machine_os_type" {
  type        = string
  description = "Which provisioning method to use, based on the OS type"
}

variable "virtual_machine_scsihw" {
  type        = string
  description = "The SCSI controller to emulate"
}

variable "virtual_machine_tablet" {
  type        = string
  description = "Enable/disable the USB tablet device. This device is usually needed to allow absolute mouse positioning with VNC."
}

variable "virtual_machine_tags" {
  type        = string
  description = "Tags of the VM. This is only meta information."
}

variable "virtual_machine_vcpus" {
  type        = string
  description = "The number of vCPUs plugged into the VM when it starts"
}

variable "virtual_machine_qemu_os" {
  type        = string
  description = "The type of OS in the guest. Set properly to allow Proxmox to enable optimizations for the appropriate guest OS. It takes the value from the source template and ignore any changes to resource configuration parameter."
}
