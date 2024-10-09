provider "aws" {
  region = var.aws_region
}

# Create RDS instance
resource "aws_db_instance" "rds_instance" {
  identifier            = var.db_identifier    # Thêm DB identifier
  allocated_storage     = var.allocated_storage
  engine                = "postgres"
  engine_version        = var.engine_version
  instance_class        = var.db_instance_class
  db_name               = var.db_name
  username              = var.db_username
  password              = var.db_password
  parameter_group_name  = "default.postgres14"
  skip_final_snapshot   = true
  db_subnet_group_name  = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = var.vpc_security_group_ids

  backup_retention_period = var.backup_retention_period
  multi_az                = var.multi_az
  publicly_accessible     = var.publicly_accessible

  tags = {
    Name = var.db_identifier
  }
}

# Subnet group for RDS
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}

# Security group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow inbound traffic for RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}
