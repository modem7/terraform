resource "proxmox_virtual_environment_file" "debian_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "<your proxmox node>"

  source_file {
    path      = "https://cdimage.debian.org/images/cloud/bullseye/20221219-1234/debian-11-genericcloud-amd64-20221219-1234.qcow2"
    file_name = "debian-11-genericcloud-amd64-20221219-1234.img"
    checksum  = "ba0237232247948abf7341a495dec009702809aa7782355a1b35c112e75cee81"
  }
}