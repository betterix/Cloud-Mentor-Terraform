vpc_cidr = "10.10.0.0/16"

vpc_name = "cmtr-ook9q7ho-vpc"
vpc_id   = "cmtr-ook9q7ho-vpc"

subnet_configs = {
  "public-a" = {
    cidr_block        = "10.10.1.0/24"
    availability_zone = "eu-west-1a"
  }
  "public-b" = {
    cidr_block        = "10.10.3.0/24"
    availability_zone = "eu-west-1b"
  }
  "public-c" = {
    cidr_block        = "10.10.5.0/24"
    availability_zone = "eu-west-1c"
  }
}

internet_gw = "cmtr-ook9q7ho-igw"

route_table = "cmtr-ook9q7ho-rt"


ssh_sg = "cmtr-ook9q7ho-ssh-sg"

public_http_sg = "cmtr-ook9q7ho-public-http-sg"

private_http_sg = "cmtr-ook9q7ho-private-http-sg"

allowed_ip_range = ["18.153.146.156/32", "79.122.81.132/32"]


template_name = "cmtr-ook9q7ho-template"

asg_name = "cmtr-ook9q7ho-asg"

applb_name = "cmtr-ook9q7ho-lb"

target_group_name = "cmtr-ook9q7ho-tg"
