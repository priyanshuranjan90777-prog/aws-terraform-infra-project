resource "aws_vpc" "terraform_vpc" {
  cidr_block =var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "terraform_vpc"
  }
}

resource "aws_subnet" "terraform_subnet" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform_subnet"
  }
}

resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "terraform_igw"
  }
}

resource "aws_route_table" "terraform_route_table" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "terraform_route_table"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.terraform_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.terraform_igw.id
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.terraform_subnet.id
  route_table_id = aws_route_table.terraform_route_table.id
}
