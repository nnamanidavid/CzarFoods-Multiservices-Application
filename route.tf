resource "aws_route_table" "czarfoods_public_rt" {
  vpc_id = aws_vpc.czarfoods_vpc.id

  tags = {
    Name = "${var.default_tags["Project"]}-public-rt"
  }
}

resource "aws_route" "czarfoods_public_rt_route" {
  route_table_id         = aws_route_table.czarfoods_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.czarfoods_igw.id
}



#PRIVATE

resource "aws_route_table" "czarfoods_private_rt" {
  vpc_id = aws_vpc.czarfoods_vpc.id

  tags = {
    Name = "${var.default_tags["Project"]}-private-rt"
  }
}

resource "aws_route" "czarfoods_private_rt_route" {
  route_table_id         = aws_route_table.czarfoods_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.czarfoods_nat_gw.id
}