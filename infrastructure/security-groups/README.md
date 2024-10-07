
# 🔐 Security Groups Configuration with Terraform

This directory contains the Terraform configuration for creating Security Groups for GitLab, PostgreSQL, and Redis services. These Security Groups ensure that only authorized network traffic is allowed to and from these services, improving the overall security of the infrastructure.

## 📋 Resources Included
- **GitLab Security Group** (`gitlab_sg`):
    - Allows HTTP (port 80), HTTPS (port 443) from anywhere.
    - Allows SSH (port 22) from a specific admin IP.
    - Allows internal communication within the VPC for GitLab components.
- **PostgreSQL Security Group** (`gitlab_db_sg`):
    - Allows GitLab to access PostgreSQL (port 5432).
- **Redis Security Group** (`gitlab_redis_sg`):
    - Allows GitLab to access Redis (port 6379).

## ✅ Prerequisites
- A VPC has already been created where these Security Groups will reside.
- Terraform is installed. To install Terraform, follow the [official documentation](https://learn.hashicorp.com/tutorials/terraform/install-cli).

## 🚀 Steps to Deploy Security Groups

### 1️⃣ Step 1: Initialize Terraform
Navigate to the `security-groups` directory and initialize Terraform to install the necessary providers and set up the local environment.

```sh
cd cloud-devops/infrastructure/security-groups/
terraform init
```

### 2️⃣ Step 2: Plan the Deployment
Run the following command to preview the changes that Terraform will apply. This helps in verifying the configuration before actual deployment.

```sh
terraform plan
```

### 3️⃣ Step 3: Apply the Configuration
Apply the Terraform configuration to create the Security Groups. Ensure that you have reviewed the plan before applying.

```sh
terraform apply
```

### 4️⃣ Step 4: Verify the Resources
After the successful deployment, verify that the Security Groups have been created by using the AWS console or AWS CLI.

## 📊 Variables
The following variables are used in this configuration. You can find them in the `variables.tf` file:

- **`region`**: The AWS region to deploy the Security Groups. Default is `"ap-northeast-1"` (Tokyo).
- **`vpc_id`**: The ID of the VPC where these Security Groups will be created.
- **`vpc_cidr`**: The CIDR block of the VPC to allow internal communication.
- **`admin_ip`**: The IP address of the admin for SSH access. Initially set to `"0.0.0.0/0"` (replace with a specific IP for better security).

## 📤 Outputs
The outputs of this module include the Security Group IDs, which can be referenced in other Terraform modules or configurations:

- **`gitlab_security_group_id`**: ID of the Security Group for GitLab.
- **`gitlab_db_security_group_id`**: ID of the Security Group for PostgreSQL used by GitLab.
- **`gitlab_redis_security_group_id`**: ID of the Security Group for Redis used by GitLab.

## 📌 Example Usage
You can use these Security Groups in other Terraform modules or resources by referencing their IDs. For example, to attach the GitLab Security Group to an EC2 instance:

```hcl
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.gitlab_sg.id,
  ]

  tags = {
    Name = "example-instance"
  }
}
```

## ⚠️ Notes
- **Security Groups** are an essential part of securing your infrastructure. Make sure to review all ingress and egress rules before applying.
- The default **admin IP** is set to `"0.0.0.0/0"`, which means **SSH** is allowed from anywhere. This should be changed to a specific IP address for enhanced security.

## 🛠️ Troubleshooting
- **Permission Denied**: Ensure that your AWS credentials are properly set up, and you have the necessary permissions to create Security Groups.
- **Port Access Issues**: If GitLab, PostgreSQL, or Redis are unable to communicate as expected, verify that the correct **CIDR block** is specified and **Security Group IDs** are correctly associated.

## 🗑️ Cleanup
To delete the Security Groups, use the following command:

```sh
terraform destroy
```

Make sure to verify that no dependent resources are using these Security Groups before deleting.

## 📜 License
This project is licensed for internal use only by employees of **Focela Technologies**. Redistribution, sublicensing, or any form of sharing of this software, either partially or fully, is strictly prohibited without prior written permission from **Focela Technologies**.

See the `LICENSE` file for more details.
