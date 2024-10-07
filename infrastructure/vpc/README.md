
# 🌐 VPC Configuration with Terraform

This directory contains the Terraform configuration for setting up a Virtual Private Cloud (VPC) on AWS. The VPC will include subnets, internet gateway, NAT gateway, and route tables necessary for building a secure and scalable network infrastructure.

## 📋 Resources Included
- **VPC** (`focela_vpc`):
  - A Virtual Private Cloud to host all services, allowing better segmentation and security.
- **Internet Gateway** (`igw`):
  - Provides internet access for the resources within public subnets.
- **Public Subnets** (`public_subnet_1`, `public_subnet_2`):
  - Two public subnets for hosting public-facing resources, each in different availability zones.
- **Private Subnets** (`private_subnet_1`, `private_subnet_2`):
  - Two private subnets for hosting internal resources, also in different availability zones.
- **Route Tables**:
  - **Public Route Table**: Routes all traffic destined for the internet to the internet gateway.
  - **Private Route Table**: Routes traffic from private subnets to the internet via a NAT gateway.
- **NAT Gateway** (`nat_gw`):
  - Allows resources in private subnets to access the internet without being publicly accessible.

## ✅ Prerequisites
- Terraform is installed. To install Terraform, follow the [official documentation](https://learn.hashicorp.com/tutorials/terraform/install-cli).
- AWS credentials are configured properly in your local environment.

## 🚀 Steps to Deploy VPC

### 1️⃣ Step 1: Initialize Terraform
Navigate to the `vpc` directory and initialize Terraform to install the necessary providers and set up the local environment.

```sh
cd cloud-devops/infrastructure/vpc/
terraform init
```

### 2️⃣ Step 2: Plan the Deployment
Run the following command to preview the changes that Terraform will apply. This helps in verifying the configuration before actual deployment.

```sh
terraform plan
```

### 3️⃣ Step 3: Apply the Configuration
Apply the Terraform configuration to create the VPC and all associated resources. Ensure that you have reviewed the plan before applying.

```sh
terraform apply
```

### 4️⃣ Step 4: Verify the Resources
After the successful deployment, verify that the VPC and its components have been created by using the AWS console or AWS CLI.

## 📊 Variables
The following variables are used in this configuration. You can find them in the `variables.tf` file:

- **`region`**: The AWS region where the VPC and subnets will be created. Default is `"ap-northeast-1"` (Tokyo).
- **`vpc_cidr`**: The CIDR block for the VPC. Default is `"10.0.0.0/16"`.
- **`public_subnet_cidr_1`**: The CIDR block for the first public subnet. Default is `"10.0.1.0/24"`.
- **`public_subnet_cidr_2`**: The CIDR block for the second public subnet. Default is `"10.0.2.0/24"`.
- **`private_subnet_cidr_1`**: The CIDR block for the first private subnet. Default is `"10.0.3.0/24"`.
- **`private_subnet_cidr_2`**: The CIDR block for the second private subnet. Default is `"10.0.4.0/24"`.

## 📤 Outputs
The outputs of this module include the following:

- **`vpc_id`**: ID of the created VPC.
- **`public_subnet_ids`**: IDs of the created public subnets.
- **`private_subnet_ids`**: IDs of the created private subnets.
- **`nat_gateway_id`**: ID of the created NAT Gateway.

## 📌 Example Usage
You can use the outputs from this VPC module to deploy other services like EC2 instances, RDS databases, or EKS clusters. For example:

```hcl
module "eks" {
  source  = "../eks"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnet_ids

  ...
}
```

## ⚠️ Notes
- **Public vs. Private Subnets**: Public subnets are accessible from the internet, whereas private subnets are not. Be careful about the services you place in each.
- **NAT Gateway Costs**: NAT Gateways incur additional costs. Consider using them only if your private subnets need access to the internet.

## 🛠️ Troubleshooting
- **Permission Denied**: Ensure that your AWS credentials are properly configured and have the necessary permissions to create VPC resources.
- **CIDR Overlapping**: Ensure that the **CIDR blocks** for your subnets do not overlap, as this can cause deployment issues.

## 🗑️ Cleanup
To delete the VPC and all associated resources, use the following command:

```sh
terraform destroy
```

Ensure that no other resources depend on the VPC before deleting.

## 📜 License
This project is licensed for internal use only by employees of **Focela Technologies**. Redistribution, sublicensing, or any form of sharing of this software, either partially or fully, is strictly prohibited without prior written permission from **Focela Technologies**.

See the `LICENSE` file for more details.
