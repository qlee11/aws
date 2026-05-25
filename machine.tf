resource "aws_instance" "tavernquest" {
  ami             = var.ami
  instance_type   = var.machine_type
  vpc_security_group_ids = [resource.aws_security_group.allow_ssh.id]

  primary_network_interface {
    network_interface_id = resource.aws_network_interface.NIC.id
  }
}