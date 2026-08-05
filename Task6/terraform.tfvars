vpc_cidr = "10.10.0.0/16"

subnet_config = {
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
