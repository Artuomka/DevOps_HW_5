variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

resource "aws_subnet" "private" {
  vpc_id     = var.vpc_id
  cidr_block = "192.168.2.0/24"

  tags = {
    Name = "hw_5_private_subnet"
  }
}



resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = {
    Name = "hw_5_private_route_table"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
