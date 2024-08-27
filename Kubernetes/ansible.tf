resource "local_file" "ansible_inventory" {
  filename = "./ansible/inventory.ini"
  content     = <<-EOF
  k8s-cp-01 ansible_host=${proxmox_virtual_environment_vm.k8s_cp_01.ipv4_addresses[1][0]} ansible_become=true
  k8s-worker-01 ansible_host=${proxmox_virtual_environment_vm.k8s_worker_01.ipv4_addresses[1][0]} ansible_become=true
  [kube_control_plane]
  k8s-cp-01
  [etcd]
  k8s-cp-01
  [kube_node]
  k8s-worker-01
  [k8s_cluster:children]
  kube_node
  kube_control_plane
  EOF

  provisioner "local-exec" {
    command = "ansible-playbook -i inventory.ini playbook.yml"
    working_dir = "ansible"
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "false"
    }
  }
}