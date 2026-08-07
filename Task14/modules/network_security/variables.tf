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
  description = "ID of the VPC where the security groups will be created"
}
