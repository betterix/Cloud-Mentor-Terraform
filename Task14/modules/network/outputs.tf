output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "ID of the VPC"
}

output "subnet_ids" {
  value       = values(aws_subnet.public)[*].id
  description = "IDs of the public subnets"
}
