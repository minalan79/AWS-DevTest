# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.6.20241010.0-kernel-6.1-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Canonical
}

resource "aws_security_group" "DevServer_sg" {
  name        = "DevServer-security-group"
  description = "DevServer security group"
  vpc_id      = "vpc-009fe926ea8f5d031"

  tags = {
    Name = "DevServer-security-group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "Allow ingress SSH" {
  security_group_id = aws_security_group.DevServer_sg.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = ["10.0.0.0/8"]
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "Allow ingress HTTP" {
  security_group_id = aws_security_group.DevServer_sg.id
  cidr_ipv4         = ["10.0.0.0/8"]
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "Allow egress All" {
  security_group_id = aws_security_group.DevServer_sg.id
  cidr_ipv4         = ["10.0.0.0/8"]
  from_port         = 0
  ip_protocol       = -1
  to_port           = 0
}
resource "aws_instance" "amazon_linux" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name = "ec2-keypair"
  vpc_security_group_ids = [aws_security_group.DevServer_sg.id]

  tags = {
    Name = var.instance_name
  }
}
