resource "aws_vpc" "test-network" {
  cidr_block = "192.168.1.0/23"
}

resource "aws_subnet" "test-subnet" {
  vpc_id     = aws_vpc.test-network.id
  cidr_block = "192.168.1.0/24"
}

resource "aws_network_interface" "test-nic" {
  subnet_id       = resource.aws_subnet.test-subnet.id
  private_ips     = ["192.168.1.112"]
  security_groups = [resource.aws_security_group.allow_ssh.id]
}