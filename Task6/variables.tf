variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "subnet_config" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  description = "Map for subnet configuration"
}
