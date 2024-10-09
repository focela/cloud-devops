
# 🔒 Security Groups Configuration

This directory contains the Terraform configuration for setting up Security Groups to secure access for GitLab, PostgreSQL, and Redis services.

## 📋 Resources Created

### The Terraform configuration in this directory creates the following resources:

#### **🔐 Security Group for GitLab**:
- Allows SSH access on port `22` for administrative control.
- Allows HTTP access on port `80` and HTTPS on port `443` for GitLab web traffic.
- Outbound traffic is allowed for all protocols.

#### **🔐 Security Group for PostgreSQL**:
- Allows access to PostgreSQL on port `5432` from GitLab and internal networks.
- Outbound traffic is allowed for all protocols.

#### **🔐 Security Group for Redis**:
- Allows access to Redis on port `6379` from GitLab and internal networks.
- Outbound traffic is allowed for all protocols.

## 🛠️ Usage

### Prerequisites

- Ensure you have AWS CLI configured and `terraform` installed locally.
- Set your AWS credentials or profile for Terraform to use.

### 🚀 Steps to deploy:

1️⃣. Initialize the Terraform workspace:
   ```bash
   terraform init
   ```

2️⃣. Review the execution plan:
   ```bash
   terraform plan
   ```

3️⃣. Apply the configuration to create the security groups:
   ```bash
   terraform apply
   ```

### 📝 Outputs

Once applied, Terraform will output the following information:

- `gitlab_sg_id`: The ID of the Security Group for GitLab.
- `postgres_sg_id`: The ID of the Security Group for PostgreSQL.
- `redis_sg_id`: The ID of the Security Group for Redis.

## 📌 Notes

- Ensure that only trusted IPs are allowed in the security groups, especially for administrative access via SSH and database connections.
- These security groups are designed to allow internal communication between GitLab, PostgreSQL, and Redis within the VPC, while restricting access from external networks.
