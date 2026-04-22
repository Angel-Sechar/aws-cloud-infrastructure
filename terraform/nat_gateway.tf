resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_a.id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "nat-ecommerce-campus"
  }
}
