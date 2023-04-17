# Creating Security Key pairs for the instance
resource "tls_private_key" "private_key" {
  rsa_bits = 4096
  algorithm = "RSA"
}

resource "local_sensitive_file" "private_key" {
  depends_on = [ aws_instance.ansibleTerraform ]
  filename = "../automation/ansibleTerraformKeyPair.pem"
  content = tls_private_key.private_key.private_key_pem
  file_permission = "0400"
}

resource "aws_key_pair" "key_pair" {
  key_name = "ansibleTerraformKeyPair"
  public_key = tls_private_key.private_key.public_key_openssh
}

