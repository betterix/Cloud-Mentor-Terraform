resource "aws_instance" "cmtr_ook9q7ho_instance" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnet.subnet.id
  vpc_security_group_ids      = [data.aws_security_group.sg.id]
  associate_public_ip_address = true

  tags = {
    Name    = "cmtr-ook9q7ho-instance"
    Project = var.project_id
  }
}
