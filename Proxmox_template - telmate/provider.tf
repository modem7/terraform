terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.6"
    }
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc7"
    }
  }
}

provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url = var.virtual_environment_endpoint
    pm_api_token_id = var.virtual_environment_api_token_id
    pm_api_token_secret = var.virtual_environment_api_token_secret
}