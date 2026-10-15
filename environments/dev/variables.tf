variable "aws_region" {
  description = "This is AWS Region"
  type        = string
}

variable "ami_id" {
  description = "This is AMI ID"
  type        = string
}

variable "instance_type" {
  description = "This is EC2 instance type"
  type        = string
}

variable "vpc_cidr_block" {
  description = "This is VPC CIDR block"
  type        = string
}

variable "subnet_cidr_block" {
  description = "This is Subnet CIDR block"
  type        = string
}

variable "availability_zone" {
  description = "This is Availability Zone"
  type        = string
}

variable "bucket_name" {
  description = "This is S3 bucket name"
  type        = string
}
variable "ssh_cidr" {
  description = "Public IP CIDR permitted to access SSH."
  type        = string
}