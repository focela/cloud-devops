# Create a Security Group for GitLab
resource "aws_security_group" "gitlab_sg" {
  name        = var.gitlab_sg_name
  description = "Security group for GitLab"
  vpc_id      = var.vpc_id

  # Allow SSH access
  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.allowed_ssh_cidr]
  }

  # Allow HTTP access
  ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.allowed_http_cidr]
  }

  # Allow HTTPS access
  ingress {
    description      = "Allow HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.allowed_https_cidr]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "GitLab Security Group"
  }
}

# Create a Security Group for PostgreSQL
resource "aws_security_group" "postgresql_sg" {
  name        = var.postgresql_sg_name
  description = "Security group for PostgreSQL"
  vpc_id      = var.vpc_id

  # Allow PostgreSQL access
  ingress {
    description      = "Allow PostgreSQL"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = [var.allowed_http_cidr]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "PostgreSQL Security Group"
  }
}

# Create a Security Group for Redis
resource "aws_security_group" "redis_sg" {
  name        = var.redis_sg_name
  description = "Security group for Redis"
  vpc_id      = var.vpc_id

  # Allow Redis access
  ingress {
    description      = "Allow Redis"
    from_port        = 6379
    to_port          = 6379
    protocol         = "tcp"
    cidr_blocks      = [var.allowed_http_cidr]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Redis Security Group"
  }
}
