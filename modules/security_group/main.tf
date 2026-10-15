resource "aws_security_group" "sg_terraform" {
  name        = "sg_terraform"
  description = "Security group for Terraform EC2"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from permitted public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-security-group"
  }
}