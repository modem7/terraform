data "local_file" "ssh_public_key" {
  filename = "./id_rsa.pub"
}

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name      = "test-ubuntu"
  node_name = "var.virtual_environment_node"

  initialization {

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      username = "ubuntu"
      keys     = [trimspace(data.local_file.ssh_public_key.content)]
    }
  }

  disk {
    datastore_id = "var.virtual_environment_datastore_id"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 15
    ssd          = 1
    cache        = writethrough
  }

    network {
        model = "virtio"
        bridge = "vmbr0"
        tag = 256

  network_device {
    bridge = "var.virtual_environment_nic"
  }
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = "var.virtual_environment_datastore_id"
  node_name    = "var.virtual_environment_node"

  url = "var.ubuntu_cloud_image_img_url"
}
