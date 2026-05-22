resource "aws_subnet" "czarfoods_public_subnet" {
  count                   = var.public_subnet_count
  vpc_id                  = aws_vpc.czarfoods_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.czarfoods_vpc.cidr_block, 8, count.index + 4)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.default_tags["Project"]}-public-subnet-${data.aws_availability_zones.available.names[count.index]}"
  }
}

resource "aws_route_table_association" "czarfoods_public_rt_assoc" {
  count          = var.public_subnet_count
  subnet_id      = element(aws_subnet.czarfoods_public_subnet.*.id, count.index)
  route_table_id = aws_route_table.czarfoods_public_rt.id
}



#PRIVATE

resource "aws_subnet" "czarfoods_private_subnet" {
  count             = var.private_subnet_count
  vpc_id            = aws_vpc.czarfoods_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.czarfoods_vpc.cidr_block, 8, count.index + 10)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.default_tags["Project"]}-private-subnet-${data.aws_availability_zones.available.names[count.index]}"
  }
}


resource "aws_route_table_association" "czarfoods_private_rt_assoc" {
  count          = var.private_subnet_count
  subnet_id      = element(aws_subnet.czarfoods_private_subnet.*.id, count.index)
  route_table_id = aws_route_table.czarfoods_private_rt.id
}



#public subnet (2)
#public route table 
#private subnet (2)
#private route table