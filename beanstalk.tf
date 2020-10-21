resource "aws_elastic_beanstalk_application" "nestjs_app" {
  name = var.env_name

  appversion_lifecycle {
    service_role = "arn:aws:iam::${var.account_id}:role/aws-elasticbeanstalk-service-role"
  }
}

resource "aws_elastic_beanstalk_application_version" "nestjs_app_ver" {
  name        = var.eb_version
  application = aws_elastic_beanstalk_application.nestjs_app.name
  bucket      = aws_s3_bucket.nestjs_app_bucket.id
  key         = aws_s3_bucket_object.dist_item.id
}

resource "aws_elastic_beanstalk_environment" "nestjs_app_eb_env" {
  name                = "${var.env_name}-env"
  application         = aws_elastic_beanstalk_application.nestjs_app.name
  solution_stack_name = var.eb_platform

  # setting {
  #   name      = "DBAllocatedStorage"
  #   namespace = "aws:rds:dbinstance"
  #   value     = 10
  # }

  # setting {
  #   name      = "DBEngine"
  #   namespace = "aws:rds:dbinstance"
  #   value     = "postgres"
  # }

  # setting {
  #   name      = "DBEngineVersion"
  #   namespace = "aws:rds:dbinstance"
  #   value     = 12
  # }

  # setting {
  #   name      = "DBInstanceClass"
  #   namespace = "aws:rds:dbinstance"
  #   value     = "db.t2.micro"
  # }

  # setting {
  #   name      = "DBPassword"
  #   namespace = "aws:rds:dbinstance"
  #   value     = var.db_password
  # }

  # setting {
  #   name      = "DBUser"
  #   namespace = "aws:rds:dbinstance"
  #   value     = var.db_username
  # }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 1
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 1
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "ImageId"
    value     = var.eb_ami
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SSHSourceRestriction"
    value     = "tcp,22,22,0.0.0.0/0"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.beanstalk_vm_sg.id
  }

  setting {
    namespace = "aws:ec2:instances"
    name      = "InstanceTypes"
    value     = "t2.micro, t2.small"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = aws_subnet.nestjs_app_subnet.0.id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = aws_vpc.nestjs_app_vpc.id
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "JWT_SECRET"
    value     = var.jwt_secret
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "TYPEORM_SYNC"
    value     = true
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_DB_NAME"
    value     = aws_db_instance.nestjs_app_db.name
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_HOSTNAME"
    value     = aws_db_instance.nestjs_app_db.address
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_PORT"
    value     = aws_db_instance.nestjs_app_db.port
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_USERNAME"
    value     = aws_db_instance.nestjs_app_db.username
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_PASSWORD"
    value     = aws_db_instance.nestjs_app_db.password
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "arn:aws:iam::${var.account_id}:role/aws-elasticbeanstalk-service-role"
  }

  setting {
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "PreferredStartTime"
    value     = "Sun:09:00"
  }

  setting {
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "ServiceRoleForManagedUpdates"
    value     = "arn:aws:iam::${var.account_id}:role/aws-elasticbeanstalk-service-role"
  }

  setting {
    namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
    name      = "UpdateLevel"
    value     = "minor"
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }
}
