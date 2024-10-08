
# 🌐 VPC Configuration

This directory contains the Terraform configuration for setting up a Virtual Private Cloud (VPC) on AWS. The VPC is the primary network where all AWS resources will be deployed, including subnets, internet gateways, and NAT gateways.

## 📋 Resources Created

### The Terraform configuration in this directory creates the following resources:
#### **🛠️ VPC**: A Virtual Private Cloud with a CIDR block of `10.0.0.0/16`.
#### **📌 Subnets**: Public and private subnets in two Availability Zones (`ap-northeast-1a` and `ap-northeast-1c`):
 - Public Subnet A: `10.0.1.0/24` (ap-northeast-1a)
 - Public Subnet C: `10.0.3.0/24` (ap-northeast-1c)
 - Private Subnet A: `10.0.2.0/24` (ap-northeast-1a)
 - Private Subnet C: `10.0.4.0/24` (ap-northeast-1c)
#### **🌍 Internet Gateway**: Provides internet access to the public subnets.
#### **🚪 NAT Gateway**: Allows private subnets to access the internet.
#### **🛣️ Route Tables**:
 - A route table for public subnets, routing internet traffic through the internet gateway.
 - A route table for private subnets, routing traffic through the NAT gateway.
#### **🔌 Elastic IP**: Allocated for the NAT Gateway.

## 🛠️ Usage

### Prerequisites

- Ensure you have AWS CLI configured and `terraform` installed locally.
- Set your AWS credentials or profile for Terraform to use.

### 🚀 Steps to deploy:

1️⃣. **Initialize the Terraform workspace**:
   ```bash
   terraform init
   ```

2️⃣. **Review the execution plan**:
   ```bash
   terraform plan
   ```

3️⃣. **Apply the configuration to create the VPC**:
   ```bash
   terraform apply
   ```

### 📝 Outputs

Once applied, Terraform will output the following information:

- `vpc_id`: The ID of the created VPC.
- `public_subnet_a_id`: The ID of Public Subnet A in `ap-northeast-1a`.
- `public_subnet_c_id`: The ID of Public Subnet C in `ap-northeast-1c`.
- `private_subnet_a_id`: The ID of Private Subnet A in `ap-northeast-1a`.
- `private_subnet_c_id`: The ID of Private Subnet C in `ap-northeast-1c`.

## 📌 Notes

- Ensure the selected Availability Zones (`ap-northeast-1a` and `ap-northeast-1c`) are available in your AWS account.
- This VPC configuration is designed to support typical AWS workloads that require internet access for public-facing resources while securing internal resources using private subnets.
