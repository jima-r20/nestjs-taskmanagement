resource "aws_elastic_beanstalk_application" "nestjs_app" {
  name = var.env_name

  appversion_lifecycle {
    service_role = "arn:aws:iam::${var.account_id}:role/aws-elasticbeanstalk-service-role"
  }
}

resource "aws_elastic_beanstalk_application_version" "nestjs_app_ver" {
  name        = "v1"
  application = aws_elastic_beanstalk_application.nestjs_app.name
  bucket      = aws_s3_bucket.nestjs_app_bucket.id
  key         = aws_s3_bucket_object.dist_item.id
}

resource "aws_elastic_beanstalk_environment" "nestjs_app_eb_env" {
  name                = "${var.env_name}-env"
  application         = aws_elastic_beanstalk_application.nestjs_app.name
  solution_stack_name = "64bit Amazon Linux 2 v5.2.2 running Node.js 12"

  setting {
    name      = "DBAllocatedStorage"
    namespace = "aws:rds:dbinstance"
    value     = 10
  }

  setting {
    name      = "DBEngine"
    namespace = "aws:rds:dbinstance"
    value     = "postgres"
  }

  setting {
    name      = "DBEngineVersion"
    namespace = "aws:rds:dbinstance"
    value     = 12
  }

  setting {
    name      = "DBInstanceClass"
    namespace = "aws:rds:dbinstance"
    value     = "db.t2.micro"
  }

  setting {
    name      = "DBPassword"
    namespace = "aws:rds:dbinstance"
    value     = var.db_password
  }

  setting {
    name      = "DBUser"
    namespace = "aws:rds:dbinstance"
    value     = var.db_username
  }

  setting {
    name      = "EnvironmentType"
    namespace = "aws:elasticbeanstalk:environment"
    value     = "SingleInstance"
  }

  setting {
    name      = "EnvironmentVariables"
    namespace = "aws:cloudformation:template:parameter"
    value     = "JWT_SECRET=${var.jwt_secret},TYPEORM_SYNC=true"
  }

  setting {
    name      = "IamInstanceProfile"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    name      = "ImageId"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = "ami-06408fceda92d06c0"
  }

  setting {
    name      = "ImageId"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = "ami-06408fceda92d06c0"
  }

  setting {
    name      = "InstanceType"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = "t2.micro"
  }

  setting {
    name      = "InstanceTypes"
    namespace = "aws:ec2:instances"
    value     = "t2.micro, t2.small"
  }

  setting {
    name      = "JWT_SECRET"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.jwt_secret
  }

  setting {
    name      = "MaxSize"
    namespace = "aws:autoscaling:asg"
    value     = 1
  }

  setting {
    name      = "MinSize"
    namespace = "aws:autoscaling:asg"
    value     = 1
  }

  setting {
    name      = "PreferredStartTime"
    namespace = "aws:elasticbeanstalk:managedactions"
    value     = "Sun:09:00"
  }

  setting {
    name      = "SSHSourceRestriction"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = "tcp,22,22,0.0.0.0/0"
  }

  setting {
    name      = "SecurityGroups"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = aws_security_group.beanstalk_vm_sg.id
  }

  setting {
    name      = "ServiceRole"
    namespace = "aws:elasticbeanstalk:environment"
    value     = "arn:aws:iam::${var.account_id}:role/aws-elasticbeanstalk-service-role"
  }

  setting {
    name      = "ServiceRoleForManagedUpdates"
    namespace = "aws:elasticbeanstalk:managedactions"
    value     = "arn:aws:iam::${var.account_id}:role/aws-elasticbeanstalk-service-role"
  }

  setting {
    name      = "Subnets"
    namespace = "aws:ec2:vpc"
    value     = aws_subnet.nestjs_app_subnet.0.id
  }

  setting {
    name      = "SystemType"
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    value     = "enhanced"
  }

  setting {
    name      = "TYPEORM_SYNC"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = true
  }

  setting {
    name      = "UpdateLevel"
    namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
    value     = "minor"
  }

  setting {
    name      = "VPCId"
    namespace = "aws:ec2:vpc"
    value     = aws_vpc.nestjs_app_vpc.id
  }
}
