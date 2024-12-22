resource "aws_security_group" "sgs" {
  for_each    = toset(var.security_group_names)
  name        = each.value
  description = "${each.value} security group"
  vpc_id      = "vpc-009fe926ea8f5d031"

  tags = {
    Name = "${each.value}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ingress_SSH" {
  for_each = {
    for sg_name, sg_resource in aws_security_group.sgs : sg_name => sg_resource.id
  }
  security_group_id = each.value
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_ingress_HTTP" {
  for_each = {
    for sg_name, sg_resource in aws_security_group.sgs : sg_name => sg_resource.id
  }
  security_group_id = each.value
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_egress_All" {
  for_each = {
    for sg_name, sg_resource in aws_security_group.sgs : sg_name => sg_resource.id
  }
  security_group_id = each.value
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = -1
  ip_protocol       = -1
  to_port           = -1
}

resource "aws_vpc_security_group_ingress_rule" "allow_ingress_Redis" {
  for_each = {
    for sg_name, sg_resource in aws_security_group.sgs : sg_name => sg_resource.id
  }
  security_group_id = each.value
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 6379
  ip_protocol       = "tcp"
  to_port           = 6379
}

resource "aws_vpc_security_group_ingress_rule" "allow_ingress_postgreDB" {
  security_group_id = aws_security_group.sgs["postgreDB-sg"].id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}