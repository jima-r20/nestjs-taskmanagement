resource "aws_route_table" "nestjs_app_rtb" {
  vpc_id = aws_vpc.nestjs_app_vpc.id

  tags = {
    Name = "${var.env_name}-rtb"
  }
}

resource "aws_route_table_association" "nestjs_app_rtb_assoc" {
  count          = length(var.availability_zones)
  route_table_id = aws_route_table.nestjs_app_rtb.id
  subnet_id      = element(aws_subnet.nestjs_app_subnet.*.id, count.index)
}

resource "aws_route" "nestjs_app_route_igw" {
  route_table_id         = aws_route_table.nestjs_app_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.nestjs_app_igw.id
  depends_on             = [aws_route_table.nestjs_app_rtb]
}
