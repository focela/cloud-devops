# ☁️ EKS Cluster Setup with Terraform

This directory contains the Terraform configuration for setting up an Amazon Elastic Kubernetes Service (EKS) cluster. It includes all the necessary resources to deploy and manage an EKS cluster within a defined VPC.

## 📋 Resources Created

The following resources will be created:

- **🔗 EKS Cluster**: Amazon EKS cluster for running Kubernetes workloads.
- **🖧 VPC Subnets**: Subnets for placing the EKS worker nodes and control plane.
- **🔐 Security Groups**: Security groups for controlling access to the EKS cluster.
- **📦 IAM Roles**: IAM roles and policies for managing permissions of EKS and worker nodes.
- **🌐 Load Balancer** (optional): For exposing Kubernetes services to the internet or internal network.
- **🔄 Outputs**: Information such as the EKS cluster endpoint and ARN of the cluster.

## 🛠️ Usage

### Prerequisites

- AWS CLI is configured and `terraform` is installed locally.
- Ensure that you have the necessary IAM permissions to create EKS clusters, VPCs, and associated resources.

### 🚀 Steps to Deploy:

1️⃣ **Initialize the Terraform workspace**:
   ```bash
   terraform init
   ```

2️⃣ **Review the execution plan**:
   ```bash
   terraform plan
   ```

3️⃣ **Apply the configuration to create the EKS cluster**:
   ```bash
   terraform apply
   ```

### 📝 Inputs

The following inputs need to be provided in your `terraform.tfvars` file:

- `aws_region`: AWS region where resources will be deployed (e.g., `"us-east-1"`, `"ap-northeast-1"`).
- `vpc_id`: The ID of the VPC in which the EKS cluster will be deployed.
- `subnet_ids`: List of subnet IDs where the EKS worker nodes will be launched.
- `cluster_name`: Name of the EKS cluster.
- `instance_type`: Instance type for EKS worker nodes (e.g., `"t3.medium"`).
- `desired_capacity`: The desired number of worker nodes in the cluster.
- `max_size`: Maximum number of worker nodes allowed.
- `min_size`: Minimum number of worker nodes.
- `node_ami_type`: The AMI type for the EKS worker nodes (e.g., `"AL2_x86_64"`).
- `allowed_cidr_blocks`: CIDR blocks that are allowed to connect to the EKS cluster.
- `cluster_role_arn`: IAM role for the EKS control plane.
- `node_role_arn`: IAM role for the EKS worker nodes.

### 📝 Outputs

After applying, Terraform will output the following information:

- `eks_cluster_id`: The ID of the created EKS cluster.
- `eks_cluster_endpoint`: The endpoint URL for the EKS control plane.
- `eks_cluster_security_group_id`: The security group ID attached to the EKS cluster.
- `eks_cluster_arn`: The ARN of the created EKS cluster.

## 📌 Notes

- Ensure the necessary IAM roles and policies are created and associated with the EKS cluster.
- Be sure to configure security groups and CIDR blocks properly to ensure secure access to the EKS cluster.
- The EKS cluster will not create a load balancer by default. You will need to configure one if you want to expose your services to the internet.

## 📚 References

- [EKS Terraform Module Documentation](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest)
- [Amazon EKS Documentation](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
