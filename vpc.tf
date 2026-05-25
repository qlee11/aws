resource "aws_vpc" "test-network" {
  cidr_block = "172.16.0.0/16"
}

resource "aws_subnet" "test-subnet"{
  vpc_id = aws_vpc.test-network.id
  cidr_block = "172.16.10.0/24"
}

resource "aws_network_interface" "NIC" {
  subnet_id   = resource.aws_vpc.test-subnet.id
  private_ips = ["172.16.10.100"]
}