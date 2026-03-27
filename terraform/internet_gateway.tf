resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ecommerce_campus_vpc.id

  tags = {
    Name = "igw-ecommerce-campus"
  }
}