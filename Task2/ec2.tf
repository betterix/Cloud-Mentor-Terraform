data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-ook9q7ho-vpc"]
  }
}

data "aws_subnet" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }

  filter {
    name   = "availability-zone"
    values = ["eu-west-1a"]
  }
}

data "aws_security_group" "sg" {
  filter {
    name   = "group-name"
    values = ["cmtr-ook9q7ho-sg"]
  }

  vpc_id = data.aws_vpc.vpc.id
}

resource "aws_instance" "cmtr_ook9q7ho_ec2" {
  ami                         = "ami-02c25106ee38f6087"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.cmtr_ook9q7ho_keypair.key_name
  vpc_security_group_ids      = [data.aws_security_group.sg.id]
  subnet_id                   = data.aws_subnet.public.id
  associate_public_ip_address = true

  tags = {
    Name    = "cmtr-ook9q7ho-ec2"
    Project = "epam-tf-lab"
    ID      = "cmtr-ook9q7ho"
  }
}
