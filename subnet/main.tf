variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

resource "aws_subnet" "public" {
  vpc_id     = var.vpc_id
  cidr_block = "192.168.1.0/24"

  tags = {
    Name = "hw_5_public_subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "hw_5_igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "hw_5_public_route_table"
  }
}



resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
