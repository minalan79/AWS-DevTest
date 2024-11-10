# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "instance_ami" {
  value = aws_instance.amazon_linux.ami
}

output "instance_arn" {
  value = aws_instance.amazon_linux.arn
}

