resource "aws_vpc" "nestjs_app_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env_name}-vpc"
  }
}
