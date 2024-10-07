provider "aws" {
  region = var.region
}

# Security Group for GitLab
resource "aws_security_group" "gitlab_sg" {
  name        = "gitlab-sg"
  description = "Security group for GitLab services"
  vpc_id      = var.vpc_id

  # Allow HTTP access from anywhere
  ingress {
    description  = "Allow HTTP"
    from_port    = 80
    to_port      = 80
    protocol     = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  # Allow HTTPS access from anywhere
  ingress {
    description  = "Allow HTTPS"
    from_port    = 443
    to_port      = 443
    protocol     = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  # Allow SSH access from a specific IP (Admin IP)
  ingress {
    description  = "Allow SSH from Admin IP"
    from_port    = 22
    to_port      = 22
    protocol     = "tcp"
    cidr_blocks  = [var.admin_ip]
  }

  # Allow internal communication within the VPC (e.g., GitLab and database servers)
  ingress {
    description  = "Allow internal traffic"
    from_port    = 1025
    to_port      = 65535
    protocol     = "tcp"
    cidr_blocks  = [var.vpc_cidr]
  }

  # Allow all outbound traffic
  egress {
    description  = "Allow all outbound traffic"
    from_port    = 0
    to_port      = 0
    protocol     = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  tags = {
    Name = "gitlab-security-group"
  }
}

# Security Group for PostgreSQL (used by GitLab)
resource "aws_security_group" "gitlab_db_sg" {
  name        = "gitlab-db-sg"
  description = "Security group for GitLab PostgreSQL"
  vpc_id      = var.vpc_id

  # Allow GitLab to access PostgreSQL (port 5432)
  ingress {
    description     = "Allow GitLab to access PostgreSQL"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.gitlab_sg.id]
  }

  # Allow all outbound traffic
  egress {
    description  = "Allow all outbound traffic"
    from_port    = 0
    to_port      = 0
    protocol     = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  tags = {
    Name = "gitlab-db-security-group"
  }
}

# Security Group for Redis (used by GitLab)
resource "aws_security_group" "gitlab_redis_sg" {
  name        = "gitlab-redis-sg"
  description = "Security group for GitLab Redis"
  vpc_id      = var.vpc_id

  # Allow GitLab to access Redis (port 6379)
  ingress {
    description     = "Allow GitLab to access Redis"
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.gitlab_sg.id]
  }

  # Allow all outbound traffic
  egress {
    description  = "Allow all outbound traffic"
    from_port    = 0
    to_port      = 0
    protocol     = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  tags = {
    Name = "gitlab-redis-security-group"
  }
}
