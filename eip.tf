resource "aws_eip" "nestjs_app_beanstalk_vm_eip" {
  vpc = true

  tags = {
    Name = "${var.env_name}-beanstalk-vm-eip"
  }
}
