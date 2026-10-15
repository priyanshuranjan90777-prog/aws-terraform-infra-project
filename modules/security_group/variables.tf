variable "vpc_id" {
  description = "VPC ID where the security group will be created."
  type        = string
}

variable "ssh_cidr" {
  description = "Public IP CIDR permitted to access SSH."
  type        = string
}
