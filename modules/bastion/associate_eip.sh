#!/bin/bash

# Set AWS region, can be omitted if the instance is using an IAM Role with region pre-configured
aws configure set region ${region}

# Retrieve the instance ID of the current EC2 instance
instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Wait until the EC2 instance is in the 'running' state
aws ec2 wait instance-running --instance-id ${instance_id}

# Associate the Elastic IP (EIP) with the EC2 instance
# 'allocation_id' refers to the ID of the Elastic IP (EIP) allocation
aws ec2 associate-address --instance-id ${instance_id} --allocation-id ${allocation_id} --allow-reassociation
