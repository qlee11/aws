resource "aws_vpc" "test-network" {
  cidr_block = "172.16.0.0/16"
}

resource "aws_subnet" "test-subnet"{
  vpc_id = aws_vpc.test-network.id
  cidr_block = "172.16.10.0/24"
}

resource "aws_network_interface" "test-nic" {
  subnet_id   = resource.aws_subnet.test-subnet.id
  private_ips = ["172.16.10.145"]
  security_groups = [resource.aws_security_group.allow_ssh.id]
}