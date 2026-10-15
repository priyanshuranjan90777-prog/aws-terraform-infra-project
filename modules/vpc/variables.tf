variable "vpc_cidr_block"{
    description = "The CIDR block for the VPC"
    type        = string
}

variable "subnet_cidr_block" {
    description = "The CIDR block for the subnet"
    type        = string
}

variable "availability_zone" {
    description = "The availability zone for the subnet"
    type        = string
}