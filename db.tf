resource "aws_db_subnet_group" "nestjs_db_subnet_group" {
  name = "${var.env_name}-db-subnet-group"
  subnet_ids = [
    aws_subnet.nestjs_app_subnet.0.id,
    aws_subnet.nestjs_app_subnet.1.id,
    aws_subnet.nestjs_app_subnet.2.id
  ]

  tags = {
    Name = "${var.env_name}-db-subnet-group"
  }
}

resource "aws_security_group" "nestjs_app_db_sg" {
  name   = "${var.env_name}-db-sg"
  vpc_id = aws_vpc.nestjs_app_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_name}-db-sg"
  }
}

resource "aws_db_parameter_group" "nestjs_app_db_pg" {
  name   = "${var.env_name}-db-pg"
  family = "postgres12"

  parameter {
    name  = "log_min_duration_statement"
    value = "100"
  }
}

resource "aws_db_instance" "nestjs_app_db" {
  identifier              = "${var.env_name}-db"
  allocated_storage       = 10
  engine                  = "postgres"
  engine_version          = "12.3"
  instance_class          = "db.t2.micro"
  name                    = var.db_name
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.nestjs_db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.nestjs_app_db_sg.id]
  parameter_group_name    = aws_db_parameter_group.nestjs_app_db_pg.name
  multi_az                = false
  backup_retention_period = "1"
  backup_window           = "15:31-16:01"
  # apply_immediately          = true
  # auto_minor_version_upgrade = false
}
