resource "aws_vpc" "czarfoods_vpc" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.default_tags["Project"]}-vpc"
  }
}

resource "aws_internet_gateway" "czarfoods_igw" {
  vpc_id = aws_vpc.czarfoods_vpc.id

  tags = {
    Name = "${var.default_tags["Project"]}-igw"
  }
}

resource "aws_nat_gateway" "czarfoods_nat_gw" {
  allocation_id = aws_eip.czarfoods_eip.id
  subnet_id     = aws_subnet.czarfoods_public_subnet[0].id
  depends_on = [aws_internet_gateway.czarfoods_igw]

  tags = {
    Name = "${var.default_tags["Project"]}-nat-gw"
  }
}

resource "aws_eip" "czarfoods_eip" {
  depends_on = [aws_internet_gateway.czarfoods_igw]

  tags = {
    Name = "${var.default_tags["Project"]}-eip"
  }
}


#vpc
#igw
#nat
#eip