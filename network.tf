resource "aws_subnet" "web_subnet" {
  vpc_id                  = "${var.vpcID}"
  cidr_block              = "${var.subnetCIDR}"
  map_public_ip_on_launch = "${var.mapPublicIP}"

  tags {
    Name = "${var.subnetName}"
  }
}

# security groups
resource "aws_security_group" "internal_sg" {
  name   = "internal_sg"
  vpc_id = "${var.vpcID}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.vpcCIDR}"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "elb_sg" {
  name        = "elb_sg"
  description = "Used in the terraform"
  vpc_id      = "${var.vpcID}"

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EIP for nat gateway
resource "aws_eip" "nat_eip" {
  vpc = true
}

# nat gateway for accesing internet
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${var.public_subnet}"

  tags {
    Name = "web_gateway"
  }
}

# route table for private subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = "${var.vpcID}"

  tags {
    Name = "Private route table"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = "${aws_route_table.private_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}

# Associate subnet  to private route table
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = "${aws_subnet.web_subnet.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}
