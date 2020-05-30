# aws-automation
Scripts & Stacks for automating AWS infrastructure

# Use Cases
- STEP#1: Script bash for awscli execution
- STEP#2: Leverage CloudFormation
 - StackA for VPC establishment. Standard 3AZ sandpit pattern
 - StackA for Internet Gateway establishment
 - StackA for NAT establishment
 - StackB for Bastion Host establishment. 1x Linux, 1x Windows
- Script Automation Host (e.g. Jenkins) establishment on an EC2 (need multiple Jenkins)
- STEP#3: Script Lambdas for boto3 capability

# CloudFormation Automation
- Script CF templates for entire various components
- See stacks directories

# Automation Host
- Deploy components to Automation Host

# Lambda-based Automation
- Script IAM create user + role + policy
- Script Dynamo Infrastructure State management
- Script Lambdas to test the infrastructure and environment + SNS + Dynamo update

# Containers
- A possibility - Fargate?

# Related
- AWS Config can be used for resource inventory

# References



