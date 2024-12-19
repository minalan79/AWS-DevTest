# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t2.micro"
}

variable "instance_name" {
  description = "EC2 instance name"
  default     = "DevServer_001"
}

variable "redis_type" {
  description = "Redis instance type"
  default     = "cache.t2micro"
}

variable "redis_parameter_group_name" {
  description = "Redis parameter group name"
  default     = "default.redis7"
}
