data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

variable "public_subnet_id" {
  description = "Public subnet ID"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID"
  type        = string
}

variable "private_security_group_id" {
  description = "Private security group ID"
  type        = string
}

variable "public_security_group_id" {
  description = "Public security group ID"
  type        = string
}

resource "aws_instance" "public_instance" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.public_security_group_id, var.private_security_group_id]
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = true

  tags = {
    Name = "hw_5_public_instance"
  }
}

resource "aws_instance" "private_instance" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.private_security_group_id]



  tags = {
    Name = "hw_5_private_instance"
  }
}
