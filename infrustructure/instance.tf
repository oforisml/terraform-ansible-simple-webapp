# Creating the instance
resource "aws_instance" "ansibleTerraform" {
  instance_type          = var.instance_type
  ami                    = "ami-007855ac798b5175e"
  subnet_id              = aws_subnet.this.id
  vpc_security_group_ids = [aws_security_group.this.id]
  key_name = aws_key_pair.key_pair.key_name

  tags = {
    Name = "AnsibleTerraformEC2"

  }
}

resource "local_file" "ip" {
    content  = aws_instance.ansibleTerraform.public_ip
    filename = "../automation/ip_address.txt"
}

resource "null_resource" "ansibleControlNode" {
  depends_on = [ aws_instance.ansibleTerraform ]

  connection {
    type = "ssh"
    user = "user"
    host = "${var.host}"
    password = "${var.password}"
  }

  provisioner "file" {
    source = "../automation"
    destination = "/home/user/Desktop/ansibleTerraform"
  }

  # Running playbook on the remote node
  provisioner "remote-exec" {
    inline = [
      "cd /home/user/Desktop/ansibleTerraform","chmod 400 ansibleTerraformKeyPair.pem", "ansible-playbook instance.yaml"
    ]

  }

}



