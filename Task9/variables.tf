variable "aws_region" {
  type        = string
  description = "the AWS region where resources are located"
}

variable "project_id" {
  type        = string
  description = "the project identifier used for tagging"
}

variable "vpc_name" {
  type        = string
  description = "the name of the VPC to discover"
}

variable "public_subnet_name" {
  type        = string
  description = "the name of the public subnet to discover"
}

variable "security_group_name" {
  type        = string
  description = "the name of the security group to discover"
}
