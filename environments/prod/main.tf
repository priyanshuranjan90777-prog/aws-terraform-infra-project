module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr_block    = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
  availability_zone = var.availability_zone
}

module "security_group" {
  source = "../../modules/security_group"

  vpc_id   = module.vpc.vpc_id
  ssh_cidr = var.ssh_cidr
}

module "ec2" {
  source = "../../modules/ec2"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.vpc.subnet_id
  security_group_id = module.security_group.sg_id
}

module "s3" {
  source = "../../modules/s3"

  bucket_name = var.bucket_name
}