locals {
  allowed_ips = {
    for ip in var.allowed_ip_range : ip => ip
  }
}

resource "aws_security_group" "ssh_sg" {
  name        = var.ssh_sg
  description = "Allow ssh"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "ssh_sg_rule" {
  for_each = local.allowed_ips

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [each.value]
  security_group_id = aws_security_group.ssh_sg.id
}

resource "aws_security_group" "public_http_sg" {
  name        = var.public_http_sg
  description = "Allow public http"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "public_http_sg_rule" {
  for_each = local.allowed_ips

  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [each.value]
  security_group_id = aws_security_group.public_http_sg.id
}

resource "aws_security_group" "private_http_sg" {
  name        = var.private_http_sg
  description = "Allow private http"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "name" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.public_http_sg.id
  security_group_id        = aws_security_group.private_http_sg.id
}
