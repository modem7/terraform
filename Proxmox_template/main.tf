provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url = "https://proxmox-server01.example.com:8006/api2/json"
    pm_password = "secret"
    pm_user = "terraform-prov@pve"
    pm_otp = ""
}

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
    name = "terraform-test-vm"
    desc = "A test for using terraform and cloudinit"

    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    node_name = "var.virtual_environment_node"

    # The template name to clone this vm from
    clone = "ubuntu2204-cloud-master-extras-template"

    # Activate QEMU agent for this VM
    agent = 1

    os_type = "cloud-init"
    cores = 2
    sockets = 1
    vcpus = 0
    cpu = "host"
    memory = 2048
    scsihw = "lsi"

    # Setup the disk
    disks {
        ide {
            ide3 {
                cloudinit {
                    storage = "local-lvm"
                }
            }
        }
        virtio {
            virtio0 {
                disk {
                    size            = 32
                    cache           = "writeback"
                    storage         = "ceph-storage-pool"
                    storage_type    = "rbd"
                    iothread        = true
                    discard         = true
                }
            }
        }
    }

    # Setup the network interface and assign a vlan tag: 256
    network {
        model = "virtio"
        bridge = "vmbr0"
        tag = 256
    }

    # Setup the ip address using cloud-init.
    boot = "order=virtio0"
    # Keep in mind to use the CIDR notation for the ip.
    ipconfig0 = "ip=192.168.10.20/24,gw=192.168.10.1"

    sshkeys = <<EOF
    ssh-rsa 9182739187293817293817293871== user@pc
    EOF
}









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
