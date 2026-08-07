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
