variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "subnet_configs" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  description = "Map for a public subnet configuration"
}
