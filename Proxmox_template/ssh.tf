resource "local_sensitive_file" "terrafrom_generated_private_key" {
  filename = "${path.module}/autogenerated/id_rsa"
  content  = tls_private_key.terrafrom.private_key_pem
}

resource "local_sensitive_file" "terrafrom_generated_public_key" {
  filename = "${path.module}/autogenerated/id_rsa.pub"
  content  = tls_private_key.terrafrom.public_key_openssh
}

resource "tls_private_key" "terrafrom" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
