resource "aws_security_group" "beanstalk_vm_sg" {
  name   = "beanstalk-vm-sg"
  vpc_id = aws_vpc.nestjs_app_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "beanstalk-vm-sg"
  }
}
