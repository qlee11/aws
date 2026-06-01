resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.ssh_key
}


resource "aws_instance" "tavernquest" {
  ami           = var.ami
  instance_type = var.machine_type
  key_name = aws_key_pair.deployer.id
  #associate_public_ip_address = true
  subnet_id = aws_subnet.test-subnet.id
  #security_groups = [ aws_security_group.allow_ssh.id ]

  primary_network_interface {
    network_interface_id = aws_network_interface.test-nic.id
  }
  
  depends_on = [aws_internet_gateway.gw]
}