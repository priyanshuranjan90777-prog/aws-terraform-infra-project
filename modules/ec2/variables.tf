variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to launch the EC2 instance in"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID to launch the EC2 instance in"
  type        = string
}
variable "security_group_id" {
  description = "Security group ID attached to the EC2 instance."
  type        = string
}      