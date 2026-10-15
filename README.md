# 🚀 AWS Terraform Infrastructure Project

![Terraform](https://img.shields.io/badge/Terraform-1.x-623CE4?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange?style=for-the-badge&logo=amazonaws)
![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04-E95420?style=for-the-badge&logo=ubuntu)
![Git](https://img.shields.io/badge/Git-Version_Control-F05032?style=for-the-badge&logo=git)

---

# 📖 Overview

This project demonstrates a **production-style modular Infrastructure as Code (IaC)** implementation using **Terraform** on **Amazon Web Services (AWS)**.

Instead of provisioning every AWS resource inside a single Terraform configuration, the infrastructure has been separated into reusable modules following industry best practices.

The project provisions:

- Amazon VPC
- Public Subnet
- Internet Gateway
- Route Table
- Security Group
- EC2 Instance
- Amazon S3 Bucket

Each resource is managed independently through reusable Terraform modules.

---

# 🏗 Architecture

```text
                    +----------------------+
                    |     Developer        |
                    +----------+-----------+
                               |
                               |
                      terraform apply
                               |
                               v
                 +--------------------------+
                 | Terraform Root Module    |
                 | environments/dev         |
                 +-----------+--------------+
                             |
        -------------------------------------------------
        |               |             |                 |
        |               |             |                 |
        v               v             v                 v
   +---------+     +-----------+   +------+     +--------------+
   |  VPC    | --> | Security  |-->| EC2  |     |     S3       |
   | Module  |     | Group     |   |Module|     |   Module     |
   +---------+     +-----------+   +------+     +--------------+
        |
        |
        v
+-------------------+
| AWS Infrastructure|
+-------------------+
```

---

# 📂 Repository Structure

```text
terraform-infra-project/
│
├── environments/
│   └── dev/
│       ├── backend.tf
│       ├── main.tf
│       ├── provider.tf
│       ├── terraform.tfvars
│       ├── variables.tf
│       └── output.tf
│
├── modules/
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── output.tf
│   │
│   ├── s3/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── output.tf
│   │
│   ├── security_group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── output.tf
│   │
│   └── vpc/
│       ├── main.tf
│       ├── variables.tf
│       └── output.tf
│
├── .gitignore
└── README.md
```

---

# 🚀 Infrastructure Components

## VPC Module

Creates:

- Custom VPC
- Public Subnet
- Internet Gateway
- Route Table
- Route Table Association

---

## Security Group Module

Creates:

- SSH Rule (22)
- HTTP Rule (80)
- HTTPS Rule (443)
- All Outbound Traffic

---

## EC2 Module

Creates:

- Ubuntu EC2 Instance
- Key Pair Association
- Security Group Attachment

---

## S3 Module

Creates

- S3 Bucket
- Bucket Configuration

---

# 📦 Features

- Modular Terraform Architecture
- Reusable Modules
- Environment Separation
- Remote State Support
- Variables Management
- Outputs Management
- Easy Deployment
- Easy Destruction
- Version Controlled Infrastructure

---

# ⚙ Technologies

- Terraform
- AWS EC2
- AWS VPC
- AWS S3
- Security Groups
- Ubuntu
- Git
- GitHub

---

# 🔧 Prerequisites

Install:

- AWS CLI
- Terraform
- Git

Configure AWS

```bash
aws configure
```

Verify

```bash
terraform --version

aws --version

git --version
```

---

# 🚀 Deployment

Initialize Terraform

```bash
terraform init
```

Validate Configuration

```bash
terraform validate
```

Preview Infrastructure

```bash
terraform plan
```

Deploy Infrastructure

```bash
terraform apply
```

---

# 🧹 Destroy Infrastructure

```bash
terraform destroy
```

---

# 🔍 Verify Resources

AWS Console

Verify

- VPC
- EC2
- Security Group
- S3 Bucket

---

# 📁 Variables

Variables are managed inside

```
terraform.tfvars
```

Example

```hcl
aws_region="us-east-1"

instance_type="t3.micro"

bucket_name="terraform-demo-bucket"

vpc_cidr="10.0.0.0/16"
```

---

# 📤 Outputs

Terraform returns

- Instance ID
- Public IP
- VPC ID
- Security Group ID
- Bucket Name

---

# 🔄 Deployment Workflow

```text
Write Terraform Code
          │
          ▼
terraform init
          │
          ▼
terraform validate
          │
          ▼
terraform plan
          │
          ▼
terraform apply
          │
          ▼
AWS Infrastructure Created
```

---

# 🔒 Best Practices Followed

✔ Modular Design

✔ Environment Separation

✔ Reusable Code

✔ Variables Instead of Hardcoding

✔ Outputs for Resource Sharing

✔ Version Control with Git

✔ Infrastructure as Code

✔ Remote Backend Ready

✔ Clean Folder Structure

---

# 📈 Future Improvements

- Auto Scaling Group
- Load Balancer
- NAT Gateway
- Multi AZ Deployment
- Private Subnets
- RDS
- CloudWatch
- IAM Roles
- Route53
- ACM
- CI/CD using GitHub Actions
- Terraform Workspaces

---

# 📸 Screenshots

Add screenshots here

- Terraform Apply
- AWS Console
- EC2
- S3
- VPC

---

# 👨‍💻 Author

**Akash Kolhe**

Cloud & DevOps Engineer

GitHub

https://github.com/akashkolhe

LinkedIn

https://linkedin.com/in/akashkolhe1

---

# ⭐ If you found this project useful

Give this repository a ⭐ on GitHub.
