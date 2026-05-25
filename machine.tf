resource "aws_instance" "tavernquest" {
  ami             = var.ami
  instance_type   = var.machine_type
  security_groups = [resource.aws_security_group.allow_ssh.id]
  
  primary_network_interface {
    network_interface_id = resource.aws_network_interface.NIC.id
  }
}