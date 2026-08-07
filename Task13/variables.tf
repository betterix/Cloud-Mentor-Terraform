variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "blue_weight" {
  type        = number
  description = "Weight of blue group"
  default     = 100
}

variable "green_weight" {
  type        = number
  description = "Weight of green group"
  default     = 0
}

variable "lb_name" {
  type        = string
  description = "Load Balancer Name"
}

variable "blue_target" {
  type        = string
  description = "Blue target group name"
}

variable "green_target" {
  type        = string
  description = "Green target group name"
}

variable "blue_template" {
  type        = string
  description = "Blue lauch template name"
}

variable "green_template" {
  type        = string
  description = "Green lauch template name"
}

variable "blue_asg" {
  type        = string
  description = "Blue autoscaling group name"
}

variable "green_asg" {
  type        = string
  description = "Green autoscaling group name"
}
