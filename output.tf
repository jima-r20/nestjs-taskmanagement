output "app_version" {
  value = aws_elastic_beanstalk_application_version.nestjs_app_ver.name
}
output "eb_env_name" {
  value = aws_elastic_beanstalk_environment.nestjs_app_eb_env.name
}
