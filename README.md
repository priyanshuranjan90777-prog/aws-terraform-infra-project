# AWS Infrastructure Automation with Terraform

A hands-on Infrastructure as Code (IaC) project that provisions and manages AWS infrastructure using reusable Terraform modules, remote state management, environment separation, and GitHub Actions CI.

## Project Overview

This project demonstrates how to automate AWS infrastructure provisioning using Terraform and organize infrastructure code using a modular, maintainable structure.

The project includes separate development and production configurations and a GitHub Actions workflow that checks Terraform formatting and validates both environments.

### Objectives

- Automate AWS infrastructure provisioning using Terraform.
- Create reusable Terraform modules.
- Separate development and production configurations.
- Store Terraform state remotely in Amazon S3.
- Apply infrastructure security best practices.
- Validate Terraform code automatically using GitHub Actions.
- Establish a foundation for secure infrastructure CI/CD.

## Architecture

```text
                    Developer
                        |
                        v
                  Git Repository
                        |
                        v
                 GitHub Actions
                        |
              Terraform CI Validation
                        |
              +---------+---------+
              |                   |
              v                   v
          Development          Production
          Environment          Environment
              |                   |
              +---------+---------+
                        |
                        v
                 Terraform Modules
                        |
           +------------+------------+
           |            |            |
           v            v            v
          VPC       Security       Amazon
                     Group           S3
           |
           v
        Subnet
           |
           v
     Internet Gateway
           |
           v
       Route Table
           |
           v
       EC2 Instance

Terraform State:
Amazon S3 Remote Backend
```

> The GitHub Actions workflow currently performs formatting checks and configuration validation. It does not automatically deploy infrastructure.

## AWS Services Used

| Service | Purpose |
|---|---|
| Amazon VPC | Provides an isolated virtual network. |
| Public Subnet | Hosts the EC2 instance with public IP assignment enabled. |
| Internet Gateway | Provides internet connectivity for the public subnet. |
| Route Table | Defines network traffic routes. |
| Security Group | Controls inbound and outbound instance traffic. |
| Amazon EC2 | Provides virtual compute capacity. |
| Amazon S3 | Stores application-related objects and Terraform remote state. |
| AWS IAM | Controls access to AWS resources. |

## Technology Stack

- **Cloud:** Amazon Web Services (AWS)
- **Infrastructure as Code:** Terraform
- **Language:** HashiCorp Configuration Language (HCL)
- **CI:** GitHub Actions
- **Version Control:** Git and GitHub
- **Operating Environment:** Windows with PowerShell

## Repository Structure

```text
aws-terraform-infra-project/
|
|-- .github/
|   |-- workflows/
|       |-- terraform.yml
|
|-- environments/
|   |-- dev/
|   |   |-- backend.tf
|   |   |-- main.tf
|   |   |-- provider.tf
|   |   |-- variables.tf
|   |   |-- output.tf
|   |   |-- .terraform.lock.hcl
|   |
|   |-- prod/
|       |-- backend.tf
|       |-- main.tf
|       |-- provider.tf
|       |-- variables.tf
|       |-- .terraform.lock.hcl
|
|-- modules/
|   |-- ec2/
|   |   |-- main.tf
|   |   |-- variables.tf
|   |   |-- output.tf
|   |
|   |-- s3/
|   |   |-- main.tf
|   |   |-- variables.tf
|   |   |-- output.tf
|   |
|   |-- security_group/
|   |   |-- main.tf
|   |   |-- variables.tf
|   |   |-- output.tf
|   |
|   |-- vpc/
|       |-- main.tf
|       |-- variables.tf
|       |-- output.tf
|
|-- Documentation/
|-- output/
|-- .gitignore
|-- README.md
```

## Terraform Modules

### 1. VPC Module

Creates the networking components required by the infrastructure:

- Virtual Private Cloud (VPC)
- Public subnet
- Internet gateway
- Route table
- Route
- Route table association

### 2. Security Group Module

Defines security rules for the EC2 instance.

SSH access is configurable through an input variable so that access can be restricted to an approved IP address or CIDR range.

### 3. EC2 Module

Creates an EC2 instance using configurable inputs, including:

- AMI ID
- Instance type
- Subnet ID
- Security group ID

The module also exposes useful outputs, including the instance ID and public IP address.

### 4. S3 Module

Creates an S3 bucket for application-related storage.

The project also uses an S3 bucket as the Terraform remote state backend.

## Environment Separation

The project contains separate Terraform root configurations for development and production.

| Environment | Purpose | Status |
|---|---|---|
| Development | Deploy and test infrastructure changes. | Applied and tested |
| Production | Maintain a separate configuration for production infrastructure. | Validated; not deployed |

Each environment has its own Terraform configuration and backend state key.

This separation helps prevent development and production infrastructure from unintentionally sharing the same Terraform state.

## Remote State Management

Terraform state is stored remotely in Amazon S3.

The backend configuration uses:

- An S3 bucket for state storage.
- Separate state keys for development and production.
- Server-side encryption.
- S3 versioning on the state bucket.
- Terraform's S3 backend lock-file mechanism using `use_lockfile = true`.

Remote state helps maintain a consistent record of infrastructure managed by Terraform.

**Important:** The backend bucket must exist before Terraform initializes the backend. Access to the bucket must also be restricted to authorized users and roles.

## GitHub Actions CI

The project includes a GitHub Actions workflow located at:

`.github/workflows/terraform.yml`

The workflow runs checks for both development and production configurations.

### Workflow stages

1. Check out the repository.
2. Install Terraform.
3. Check Terraform formatting.
4. Initialize Terraform without configuring the remote backend.
5. Validate the Terraform configuration.

### Current CI result

The workflow has completed successfully for both environments.

- Development formatting and validation: Passed
- Production formatting and validation: Passed

The workflow currently checks code quality and configuration validity. AWS-backed planning, security scanning, and automated deployment are planned improvements.

## Prerequisites

Install the following tools before running the project:

- Terraform CLI
- AWS CLI
- Git
- A code editor such as Visual Studio Code
- An AWS account with appropriate IAM permissions

Verify the installations:

```powershell
terraform --version
aws --version
git --version
```

## Configuration and Deployment

### 1. Authenticate with AWS

Configure AWS CLI authentication using an approved method.

Verify the active identity:

```powershell
aws sts get-caller-identity
```

Do not store AWS access keys or other credentials in the repository.

### 2. Configure environment variables

Each environment requires its own local `terraform.tfvars` file.

Example development configuration:

```hcl
aws_region        = "us-east-1"
ami_id            = "YOUR_VALID_AMI_ID"
instance_type     = "t3.micro"
vpc_cidr_block    = "10.0.0.0/16"
subnet_cidr_block = "10.0.1.0/24"
availability_zone = "us-east-1a"
bucket_name       = "YOUR_GLOBALLY_UNIQUE_BUCKET_NAME"
ssh_cidr          = "YOUR_PUBLIC_IP/32"
```

Replace the example values with values appropriate for your AWS account.

Use a unique S3 bucket name and restrict SSH access to a trusted IP address. Never commit local `terraform.tfvars` files to Git.

### 3. Initialize Terraform

Run the following commands from the project root.

For development:

```powershell
terraform -chdir=environments/dev init
```

For production:

```powershell
terraform -chdir=environments/prod init
```

Ensure that the backend bucket and permissions are configured before initialization.

### 4. Format and validate

Development:

```powershell
terraform -chdir=environments/dev fmt -check
terraform -chdir=environments/dev validate
```

Production:

```powershell
terraform -chdir=environments/prod fmt -check
terraform -chdir=environments/prod validate
```

### 5. Review the execution plan

Development:

```powershell
terraform -chdir=environments/dev plan
```

Production:

```powershell
terraform -chdir=environments/prod plan
```

Review the plan carefully before making infrastructure changes.

### 6. Apply changes

**Warning:** Applying Terraform can create billable AWS resources or modify existing infrastructure.

After reviewing the plan and confirming the intended changes, apply the development configuration:

```powershell
terraform -chdir=environments/dev apply
```

Production changes should only be applied after a separate review, approval, and verification of the production configuration.

## Security Practices

The project incorporates or is designed to support the following practices:

- Use Terraform variables for configurable infrastructure values.
- Exclude local variable files and Terraform state files from Git.
- Commit Terraform provider lock files for consistent provider selection.
- Store remote Terraform state in S3.
- Enable encryption and versioning for the state bucket.
- Restrict SSH access using a configurable CIDR range.
- Use AWS IAM permissions appropriate to the task.
- Review Terraform plans before applying infrastructure changes.
- Validate infrastructure configuration through GitHub Actions.

Further security scanning and secure AWS authentication for GitHub Actions are planned improvements.

## Troubleshooting

### Terraform initialization fails

Check the AWS identity, permissions, backend bucket name, region, and backend configuration.

### Terraform validation fails

Review the error message, correct the Terraform configuration, and run `terraform fmt` followed by `terraform validate`.

### EC2 SSH access fails

Verify the instance's public IP, instance state, security group rules, network routing, and SSH configuration.

### GitHub Actions fails

Open the failed workflow run, inspect the logs for the relevant environment, and correct the reported configuration or workflow issue.

## Future Improvements

- Add Terraform security scanning with Checkov.
- Add Terraform plan checks to the CI workflow.
- Configure GitHub Actions authentication to AWS using OIDC.
- Introduce protected production deployment approvals.
- Add automated infrastructure drift checks.
- Expand monitoring and logging.
- Improve infrastructure diagrams and deployment documentation.

## Documentation

The `Documentation/` directory contains the project's practical guide.

The `output/` directory contains screenshots associated with the project.

## Author

**Priyanshu Ranjan**

Aspiring DevOps Engineer | AWS | Terraform | Docker | Kubernetes | CI/CD

GitHub: [View my GitHub profile](https://github.com/priyanshuranjan90777-prog)