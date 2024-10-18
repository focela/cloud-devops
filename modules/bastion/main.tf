# Allocate an Elastic IP for the Bastion host
resource "aws_eip" "bastion_eip" {
  domain = "vpc"

  tags = {
    Name = "gitlab-eip-bastion"
  }
}

# Create IAM Policy to allow EC2 instance to associate Elastic IP
resource "aws_iam_policy" "bastion_eip_association" {
  name        = "bastion-eip-association"
  path        = "/"
  description = "Permissions to associate an EIP to a Bastion instance"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DescribeAddresses",
        "ec2:AllocateAddress",
        "ec2:DescribeInstances",
        "ec2:AssociateAddress"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

# Create an IAM Role for EC2 to assume, allowing it to associate the EIP
resource "aws_iam_role" "bastion_eip_association_role" {
  name               = "bastion-eip-association"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Attach the IAM Policy to the Role
resource "aws_iam_role_policy_attachment" "bastion_eip_policy_attachment" {
  role       = aws_iam_role.bastion_eip_association_role.name
  policy_arn = aws_iam_policy.bastion_eip_association.arn
}

# Create an IAM Instance Profile for the EC2 instance to assume
resource "aws_iam_instance_profile" "bastion_eip_instance_profile" {
  name = "bastion-eip-association"
  role = aws_iam_role.bastion_eip_association_role.name
}

# Find the latest Amazon Linux 2 AMI for EC2
data "aws_ami" "bastion_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

# Use template file for the EIP association script
data "template_file" "eip_association_script" {
  template = "${file("../../modules/bastion/associate_eip.sh")}"

  vars = {
    eip    = aws_eip.bastion_eip.id
    region = var.region
  }
}

# Launch Template for the Bastion EC2 instance
resource "aws_launch_template" "bastion_launch_template" {
  name_prefix   = "Bastion"
  image_id      = data.aws_ami.bastion_ami.id
  instance_type = var.instance_type
  key_name      = var.bastion_key_name
  iam_instance_profile {
    name = aws_iam_instance_profile.bastion_eip_instance_profile.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.bastion_sg.id]
  }

  user_data = base64encode(data.template_file.eip_association_script.rendered)

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "bastion-instance"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Autoscaling Group to ensure a single instance of Bastion is always running
resource "aws_autoscaling_group" "bastion_asg" {
  name                 = "gitlab-bastion"
  health_check_type    = "EC2"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = var.subnet_ids

  launch_template {
    id      = aws_launch_template.bastion_launch_template.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "gitlab-bastion"
    propagate_at_launch = true
  }
}

# Security Group for Bastion instance, allowing SSH access
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sec-group"
  vpc_id      = var.vpc_id
  description = "Security group for the gitlab bastion"

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.whitelist_ssh_ip
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sec-group"
  }
}
