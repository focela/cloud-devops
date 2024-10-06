
# 🏗️ AWS VPC Infrastructure Setup using Terraform

This directory contains the Terraform configuration files for setting up an Amazon Web Services (AWS) Virtual Private Cloud (VPC) infrastructure. This setup is part of the internal network configuration for Focela, aimed at managing multiple services effectively.

- 📜 **main.tf**: Contains the core resource definitions for the AWS VPC, subnets, route tables, and other related components.
- 📦 **variables.tf**: Defines input variables to parameterize the configuration, allowing more flexibility and easier customization.
- 📤 **outputs.tf**: Manages output values, making it easier to access important resource information after the deployment.
- 🔒 **.terraform.lock.hcl**: Ensures consistent provider versions across different environments and developers, maintaining stability.
- 💾 **terraform.tfstate** and **terraform.tfstate.backup**: Files used to store the current state of the infrastructure, which allows Terraform to manage and track changes effectively.

## 📋 Prerequisites

- Terraform version >= 1.0.0
- AWS CLI configured with credentials for deployment

## 🚀 Getting Started

1. **Initialize Terraform**:  
   Run the following command to initialize Terraform and download provider plugins:
   ```sh
   terraform init
   ```

2. **Plan the Infrastructure**:  
   Run a plan to see the changes Terraform will apply:
   ```sh
   terraform plan
   ```

3. **Apply the Configuration**:  
   Deploy the infrastructure by running:
   ```sh
   terraform apply
   ```

4. **Verify the Output**:  
   After successful deployment, check the output values, such as VPC ID and subnet IDs, which will be displayed in the terminal.

## 🛠️ Variables

To customize the configuration, you can modify the variables in `variables.tf` or pass values during runtime using a `.tfvars` file or command-line options.

## 🔍 Notes

- The `.terraform.lock.hcl` file must be included to ensure consistent provider versions and stability across different environments.
- It is recommended not to version control `terraform.tfstate` and `terraform.tfstate.backup` files due to the sensitive information they contain. Ensure these files are ignored in your `.gitignore`.

## 📄 License

This project is licensed under Focela Technologies. For more information, please see the [LICENSE](../../LICENSE) file.