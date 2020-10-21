region = "ap-northeast-1"
availability_zones = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]

env_name = "nestjs-app"

eb_platform = "64bit Amazon Linux 2 v5.2.2 running Node.js 12"
eb_version = "v1"
eb_ami = "ami-06408fceda92d06c0"

db_name = "NestjsAppDB"
db_port = 5432

vpc_cidr = "10.0.0.0/16"

dist_zip = "nestjs-app.zip"