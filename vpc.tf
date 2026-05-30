# VPC configuration
#------------------------------------
resource "aws_vpc" "test-network" {
  cidr_block = "192.168.0.0/23"
}

resource "aws_subnet" "test-subnet" {
  vpc_id     = aws_vpc.test-network.id
  cidr_block = "192.168.1.0/24"
}
#------------------------------------

# Instance Connect Endpoint + Internet gateway and route table entry to ensure connectivity to the internet
#------------------------------------
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.test-network.id
  depends_on = [ aws_vpc.test-network ]
}

resource "aws_ec2_instance_connect_endpoint" "connect" {
  subnet_id = aws_subnet.test-subnet.id
  security_group_ids = [aws_security_group.allow_ssh.id]
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.test-network.id
  depends_on = [aws_internet_gateway.gw]
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.test-network.id
  route_table_id = aws_route_table.rt.id
  depends_on = [aws_route_table.rt]
}
#------------------------------------