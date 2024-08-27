resource "local_sensitive_file" "example_ssh_private_key" {
  filename = "${path.module}/autogenerated/id_rsa"
  content  = tls_private_key.example.private_key_pem
}

resource "local_sensitive_file" "example_ssh_public_key" {
  filename = "${path.module}/autogenerated/id_rsa.pub"
  content  = tls_private_key.example.public_key_openssh
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}