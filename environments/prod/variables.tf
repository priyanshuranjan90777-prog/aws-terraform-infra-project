variable "aws_region" {
  description = "AWS region for production resources"
  type        = string
}

variable "ami_id" {
  description = "Amazon Linux EC2 AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "vpc_cidr_block" {
  description = "Production VPC CIDR block"
  type        = string
}

variable "subnet_cidr_block" {
  description = "Production subnet CIDR block"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for production subnet"
  type        = string
}

variable "bucket_name" {
  description = "Globally unique production S3 bucket name"
  type        = string
}

variable "ssh_cidr" {
  description = "Public IP CIDR allowed to access SSH"
  type        = string
}