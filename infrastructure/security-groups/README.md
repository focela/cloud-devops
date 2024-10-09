
# 🔐 Security Groups Configuration

This directory contains the Terraform configuration for setting up security groups for various services including GitLab, Redis, PostgreSQL (RDS), and EKS.

## 📋 Security Groups Created

The following security groups are created by this Terraform configuration:

### **🛡️ GitLab Security Group**:
- Allows inbound traffic on:
    - **🌐 Port 80**: HTTP traffic
    - **🔒 Port 443**: HTTPS traffic
    - **🔑 Port 22**: SSH traffic for Git repository access

### **💾 Redis Security Group**:
- Allows inbound traffic on:
    - **🔌 Port 6379**: Redis communication

### **🗄️ PostgreSQL (RDS) Security Group**:
- Allows inbound traffic on:
    - **📡 Port 5432**: PostgreSQL communication

### **⚙️ EKS Node Security Group**:
- Allows inbound traffic on:
    - **🔑 Port 22**: SSH access for managing EKS nodes
    - **🔒 Port 443**: HTTPS communication for Kubernetes API
    - **🔄 Port 10250**: Kubernetes node communication

### **🛠️ EKS Control Plane Security Group**:
- Allows inbound traffic on:
    - **🔒 Port 443**: HTTPS communication for Kubernetes API
    - **🔄 Port 10250**: Kubernetes node communication

## 🛠️ Usage

### Prerequisites

- Ensure you have AWS CLI configured and `terraform` installed locally.
- Set your AWS credentials or profile for Terraform to use.

### 🚀 Steps to deploy:

1️⃣ **Initialize the Terraform workspace**:
   ```bash
   terraform init
   ```

2️⃣ **Review the execution plan**:
   ```bash
   terraform plan
   ```

3️⃣ **Apply the configuration to create the RDS instance**:
   ```bash
   terraform apply
   ```

### 📝 Outputs

Once applied, Terraform will output the following information:

- `🛡️ gitlab_security_group_id`: The ID of the security group for GitLab
- `💾 redis_security_group_id`: The ID of the security group for Redis
- `🗄️ postgres_security_group_id`: The ID of the security group for PostgreSQL (RDS)
- `⚙️ eks_node_security_group_id`: The ID of the security group for EKS nodes
- `🛠️ eks_control_security_group_id`: The ID of the security group for EKS control plane

## 📌 Notes

- Ensure the correct VPC ID and CIDR blocks are provided in the `terraform.tfvars` file.
- You can customize the allowed inbound traffic by modifying the `allowed_cidr_blocks` in `terraform.tfvars` or directly in the security group definitions.
