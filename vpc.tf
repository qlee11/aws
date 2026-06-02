# VPC configuration
#------------------------------------
resource "aws_vpc" "test-network" {
  cidr_block = "172.16.0.0/24"
}

resource "aws_subnet" "test-subnet" {
  vpc_id     = aws_vpc.test-network.id
  cidr_block = "172.16.0.0/28"
}

resource "aws_subnet" "cluster-subnet" {
  vpc_id     = aws_vpc.test-network.id
  cidr_block = "172.16.64.0/28"
  availability_zone = "eu-central-1b"
}

resource "aws_network_interface" "test-nic" {
  subnet_id   = aws_subnet.test-subnet.id
  private_ips = ["172.16.0.10"]

  tags = {
    Name = "primary_network_interface"
  }
}


#------------------------------------

# Instance Connect Endpoint + Internet gateway and route table entry to ensure connectivity to the internet
#------------------------------------
# resource "aws_internet_gateway" "gw" {
#   vpc_id = aws_vpc.test-network.id
#   depends_on = [ aws_vpc.test-network ]
# }

resource "aws_ec2_instance_connect_endpoint" "connect" {
  #depends_on = [ aws_route_table.internet-gw ]
  subnet_id = aws_subnet.test-subnet.id
  ip_address_type = "ipv4"
  preserve_client_ip = "true"
  security_group_ids = [aws_security_group.allow_instance_connect_endpoint.id]
}

resource "aws_route_table" "nic-rt" {
  vpc_id = aws_vpc.test-network.id
  depends_on = [aws_network_interface.test-nic]
  route {
    cidr_block = "0.0.0.0/0"
    network_interface_id = aws_network_interface.test-nic.id
  }
}

# resource "aws_route_table" "ec2-instance-connect" {
#   vpc_id = aws_vpc.test-network.id
#   depends_on = [aws_internet_gateway.gw]
#   route {
#     cidr_block = "172.16.0.0/24"
#     gateway_id = aws_instance.tavernquest.id
#   }
# }

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.test-network.id
  route_table_id = aws_route_table.nic-rt.id
  depends_on = [aws_route_table.nic-rt]
}
#------------------------------------