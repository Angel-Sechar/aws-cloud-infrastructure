resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.ecommerce_campus_vpc.id
  cidr_block        = var.public_subnet_a_cidr
  availability_zone = var.availability_zone_a
  tags              = { Name = "public-subnet-01" }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.ecommerce_campus_vpc.id
  cidr_block        = var.public_subnet_b_cidr
  availability_zone = var.availability_zone_b
  tags              = { Name = "public-subnet-02" }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.ecommerce_campus_vpc.id
  cidr_block        = var.private_subnet_a_cidr
  availability_zone = var.availability_zone_a
  tags              = { Name = "private-subnet-01" }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.ecommerce_campus_vpc.id
  cidr_block        = var.private_subnet_b_cidr
  availability_zone = var.availability_zone_b
  tags              = { Name = "private-subnet-02" }
}
