variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

resource "aws_security_group" "private" {
  name        = "private"
  description = "Private security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "hw_5_private_sg"
  }
}

resource "aws_security_group" "public" {
  name        = "public"
  description = "Public security group. Allow SSH and HTTP connections"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["46.10.149.23/32"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "hw_5_public_sg"
  }
}
