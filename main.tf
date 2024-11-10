# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

# data "aws_ami" "amazon_linux" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-2.0.20231011.1-x86_64-gp2"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["137112412989"] # Canonical
# }

resource "aws_instance" "amazon_linux" {
  ami           = "ami-06b21ccaeff8cd686"
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
