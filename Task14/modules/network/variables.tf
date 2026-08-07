variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "vpc_name" {
  type        = string
  description = "VPC name"
}

variable "subnet_configs" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  description = "Map for a public subnet configuration"
}

variable "internet_gw" {
  type        = string
  description = "Internet Gateway name"
}

variable "route_table" {
  type        = string
  description = "Route table name"
}
