variable "template_name" {
  type        = string
  description = "Template is name"
}

variable "asg_name" {
  type        = string
  description = "Auto Scaling group name"
}

variable "applb_name" {
  type        = string
  description = "App loadbalancer name"
}

variable "target_group_name" {
  type        = string
  description = "Target group name"
}


variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for the load balancer and Auto Scaling group"
}

variable "ssh_sg_id" {
  type        = string
  description = "ID of the SSH security group"
}

variable "public_http_sg_id" {
  type        = string
  description = "ID of the public HTTP security group"
}

variable "private_http_sg_id" {
  type        = string
  description = "ID of the private HTTP security group"
}
