variable "aws_region" {
  type        = string
  description = "AWS region for the resources"
}

variable "project_id" {
  type        = string
  description = "project identifier used for tagging"
}

variable "state_bucket" {
  type        = string
  description = "S3 bucket name that stores the remote state"
}

variable "state_key" {
  type        = string
  description = "S3 key path to the remote state file"
}
