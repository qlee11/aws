resource "aws_vpc" "test-network" {
  cidr_block = "192.168.0.0/23"
}

resource "aws_subnet" "test-subnet" {
  vpc_id     = aws_vpc.test-network.id
  cidr_block = "192.168.1.0/24"
}