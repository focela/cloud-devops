
# 📦 RDS PostgreSQL Setup with Terraform

This directory contains the Terraform configuration to set up an Amazon RDS PostgreSQL instance. It includes security groups, subnets, and other configurations needed for deploying and managing the database in AWS.

## 📋 Resources Created

- **🗄️ RDS Instance**: A PostgreSQL RDS instance with the following details:
  - **🔖 DB Identifier**: The name of the RDS instance (e.g., `my-rds-instance`).
  - **⚙️ Engine**: PostgreSQL.
  - **📅 Engine Version**: Defined in the configuration (e.g., `14.1`).
  - **🖥️ DB Instance Class**: Defined for the instance type (e.g., `db.t3.medium`).
  - **💾 Storage**: Allocated storage (e.g., 20 GB).
  - **🔄 Backup Retention Period**: Number of days to retain backups.
  - **🌍 Multi-AZ Deployment**: Whether the instance is deployed in multiple availability zones.

- **📂 DB Subnet Group**: A subnet group with subnets specified for the RDS instance.

- **🔐 Security Group**: A security group allowing access to the PostgreSQL instance on port 5432.

## 🛠️ Usage

### Prerequisites

- Ensure you have AWS CLI configured and `terraform` installed locally.
- Set your AWS credentials or profile for Terraform to use.

### 🚀 Steps to Deploy:

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

- **🆔 rds_instance_id**: The ID of the created RDS instance.
- **🔗 rds_endpoint**: The endpoint to connect to the RDS instance.
- **🔖 rds_db_identifier**: The DB identifier for the RDS instance.

### 📌 Notes

- Ensure that the subnets and security groups defined in the configuration are properly set up for your VPC.
- The `db_identifier` will be used to uniquely identify the RDS instance within AWS.

## 📚 References

- [Terraform RDS Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance)
- [Amazon RDS Documentation](https://aws.amazon.com/rds/postgresql/)
