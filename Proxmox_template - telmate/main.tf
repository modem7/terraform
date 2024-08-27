resource "proxmox_vm_qemu" "cloudinit-test" {
    name = "terraform-test-vm"
    desc = "A test for using terraform and cloudinit"

    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = var.virtual_environment_node

    # The template name to clone this vm from
    clone = "ubuntu2204-cloud-master-extras-template"

    # Activate QEMU agent for this VM
    agent = 1

    balloon = var.virtual_machine_balloon
    bios    = var.virtual_machine_bios
    cores   = var.virtual_machine_cores
    cpu     = var.virtual_machine_cpu
    memory  = var.virtual_machine_memory
    os_type = var.virtual_machine_os_type
    scsihw  = var.virtual_machine_scsihw
    tablet  = var.virtual_machine_tablet
    tags    = var.virtual_machine_tags
    qemu_os = var.virtual_machine_qemu_os
    vcpus   = var.virtual_machine_vcpus

    # Setup the disks
    disks {
        scsi {
            scsi0 {
                disk {
                  backup     = true
                  cache      = "writethrough"
                  discard    = true
                  emulatessd = true
                  iothread   = true
                  replicate  = true
                  size       = "15G"
                  storage    = var.virtual_environment_datastore_id
                }
            }
            scsi1 {
                cloudinit {
                  storage = var.virtual_environment_datastore_id
                }
            }
        }
    }

#    efidisk {
#        efitype = "4m"
#        storage = var.virtual_environment_datastore_id
#    }

    # Setup the network interface and assign a vlan tag: 50
    network {
        model = "virtio"
        bridge = var.virtual_environment_nic
        tag = 50
    }

    # Setup the ip address using cloud-init.
    boot = "order=scsi0"
    # Keep in mind to use the CIDR notation for the ip.
    # ipconfig0 = "ip=192.168.10.20/24,gw=192.168.10.1"
    ipconfig0 = "ip=dhcp"

    sshkeys = ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOFLnUCnFyoONBwVMs1Gj4EqERx+Pc81dyhF6IuF26WM proxvms
}
