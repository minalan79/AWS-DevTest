# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

# data "aws_ami" "amazon_linux" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["al2023-ami-2023.6.20241010.0-kernel-6.1-x86_64"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["137112412989"] # Canonical
# }

resource "aws_instance" "amazon_linux" {
  # ami           = data.aws_ami.amazon_linux.id
  ami = "ami-0583d8c7a9c35822c"
  instance_type = var.instance_type
  key_name = "EC2-keypair"
  vpc_security_group_ids = [ aws_security_group.sgs["devServer-sg"].id ]

  tags = {
    Name = var.instance_name
  }
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis-cluster-001"
  engine               = "redis"
  node_type            = var.redis_type
  num_cache_nodes      = 1
  parameter_group_name = var.redis_parameter_group_name
  port                 = 6379
  security_group_ids   = [ aws_security_group.sgs["redisCache-sg"].id ]
}

resource "aws_db_instance" "postgreDB" {
  allocated_storage      = 10
  db_name                = "POSTGRESQL01"
  engine                 = "postgres"
  instance_class         = "db.t4g.micro"
  username               = "postgreAdmin"
  password               = var.rds_password
  skip_final_snapshot    = true
  storage_type           = "gp2"
  vpc_security_group_ids = [ aws_security_group.sgs["postgreDB-sg"].id ]
  port                   = 5432
  multi_az               = false
  identifier             = var.rds_name 
}