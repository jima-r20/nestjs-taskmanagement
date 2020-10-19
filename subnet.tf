resource "aws_subnet" "nestjs_app_subnet" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.nestjs_app_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.env_name}-subnet-${count.index}"
  }
}
