resource "aws_internet_gateway" "nestjs_app_igw" {
  vpc_id = aws_vpc.nestjs_app_vpc.id

  tags = {
    Name = "${var.env_name}-igw"
  }
}
