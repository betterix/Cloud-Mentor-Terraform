variable "allowed_ip_range" {
  type = list(object({
    ip_address = string
  }))
  description = "a list of IP ranges allowed to access the infrastructure"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "public_subnet_id" {
  type        = string
  description = "Public subnet ID"
}

variable "private_subnet_id" {
  type        = string
  description = "Private subnet ID"
}

variable "public_instance_id" {
  type        = string
  description = "Public EC2 instance ID"
}

variable "private_instance_id" {
  type        = string
  description = "Private EC2 instance ID"
}
