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

variable "ssh_sg" {
  type        = string
  description = "Ingress rule to allow ssh"
}

variable "public_http_sg" {
  type        = string
  description = "Ingress rule to allow public http"
}

variable "private_http_sg" {
  type        = string
  description = "Ingress rule to allow private http"
}

variable "allowed_ip_range" {
  type        = list(string)
  description = "Allowed IPs"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}


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
