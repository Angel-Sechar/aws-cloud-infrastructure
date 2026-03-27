resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.ecommerce_campus_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "public-subnet-01"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.ecommerce_campus_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "sa-east-1c"

  tags = {
    Name = "public-subnet-02"
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.ecommerce_campus_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "private-subnet-01"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.ecommerce_campus_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "sa-east-1c"

  tags = {
    Name = "private-subnet-02"
  }
}