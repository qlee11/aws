resource "aws_instance" "tavernquest" {
  ami             = var.ami
  instance_type   = var.machine_type

  primary_network_interface {
    network_interface_id = resource.aws_network_interface.test-nic.id
  }
}