# SG for the EC" instance
#--------------------------------------------
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = resource.aws_vpc.test-network.id
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = resource.aws_security_group.allow_ssh.id
  cidr_ipv4         = "172.16.0.0/28"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = resource.aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port = 443
  ip_protocol       = "tcp"
  to_port = 8080
}
#--------------------------------------------

# SG for the Instance Connect Endpoint
#--------------------------------------------
resource "aws_security_group" "allow_instance_connect_endpoint" {
  name        = "allow_instance_connect_endpoint"
  description = "Allow allow_instance_connect_endpoint to the EC2 machine"
  vpc_id      = resource.aws_vpc.test-network.id
}

resource "aws_vpc_security_group_ingress_rule" "private" {
  security_group_id = aws_security_group.allow_instance_connect_endpoint.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "ec2" {
  security_group_id = aws_security_group.allow_instance_connect_endpoint.id
  cidr_ipv4         = "172.16.0.0/28"
  from_port = 22
  ip_protocol       = "tcp"
  to_port = 22
}
#--------------------------------------------