locals {
  allowed_ips = {
    for ip in var.allowed_ip_range : ip.ip_address => ip
  }
}

resource "aws_security_group" "ssh_sg" {
  name        = "cmtr-ook9q7ho-ssh-sg"
  description = "Allow ssh and icmp"
  vpc_id      = var.vpc_id

  tags = {
    Project = "cmtr-ook9q7ho"
  }
}

resource "aws_security_group_rule" "ssh_sg_ssh_rule" {
  for_each = local.allowed_ips

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [each.value.ip_address]
  security_group_id = aws_security_group.ssh_sg.id
}

resource "aws_security_group_rule" "ssh_sg_icmp_rule" {
  for_each = local.allowed_ips

  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [each.value.ip_address]
  security_group_id = aws_security_group.ssh_sg.id
}

resource "aws_security_group" "http_sg" {
  name        = "cmtr-ook9q7ho-public-http-sg"
  description = "Allow http and icmp"
  vpc_id      = var.vpc_id

  tags = {
    Project = "cmtr-ook9q7ho"
  }
}

resource "aws_security_group_rule" "http_sg_http_rule" {
  for_each = local.allowed_ips

  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [each.value.ip_address]
  security_group_id = aws_security_group.http_sg.id
}

resource "aws_security_group_rule" "http_sg_icmp_rule" {
  for_each = local.allowed_ips

  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [each.value.ip_address]
  security_group_id = aws_security_group.http_sg.id
}

resource "aws_security_group" "private_http_sg" {
  name        = "cmtr-ook9q7ho-private-http-sg"
  description = "Allow http and icmp"
  vpc_id      = var.vpc_id

  tags = {
    Project = "cmtr-ook9q7ho"
  }
}

resource "aws_security_group_rule" "private_http_sg_http_rule" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.http_sg.id
  security_group_id        = aws_security_group.private_http_sg.id
}

resource "aws_security_group_rule" "private_http_sg_icmp_rule" {
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  source_security_group_id = aws_security_group.http_sg.id
  security_group_id        = aws_security_group.private_http_sg.id
}

data "aws_network_interface" "public_eni" {
  filter {
    name   = "attachment.instance-id"
    values = [var.public_instance_id]
  }
}

data "aws_network_interface" "private_eni" {
  filter {
    name   = "attachment.instance-id"
    values = [var.private_instance_id]
  }
}

resource "aws_network_interface_sg_attachment" "public_ssh_sg" {
  security_group_id    = aws_security_group.ssh_sg.id
  network_interface_id = data.aws_network_interface.public_eni.id
}

resource "aws_network_interface_sg_attachment" "public_http_sg" {
  security_group_id    = aws_security_group.http_sg.id
  network_interface_id = data.aws_network_interface.public_eni.id
}

resource "aws_network_interface_sg_attachment" "private_http_sg" {
  security_group_id    = aws_security_group.private_http_sg.id
  network_interface_id = data.aws_network_interface.private_eni.id
}
