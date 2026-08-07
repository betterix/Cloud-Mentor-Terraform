data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-ook9q7ho-vpc"]
  }
}

data "aws_subnet" "public1" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-ook9q7ho-public-subnet1"]
  }
}

data "aws_subnet" "public2" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-ook9q7ho-public-subnet2"]
  }
}

data "aws_security_group" "sg_ssh" {
  name = "cmtr-ook9q7ho-sg-ssh"
}

data "aws_security_group" "sg_http" {
  name = "cmtr-ook9q7ho-sg-http"
}

data "aws_security_group" "sg_lb" {
  name = "cmtr-ook9q7ho-sg-lb"
}
