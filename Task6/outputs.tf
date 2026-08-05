output "vpc_id" {
  description = "the ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "vpc_cidr" {
  description = "the CIDR block of the VPC"
  value       = aws_vpc.vpc.cidr_block
}

output "public_subnet_ids" {
  description = "the IDs of all public subnets"
  value       = { for k, v in aws_subnet.subnet : k => v.id }
}

output "public_subnet_cidr_block" {
  description = "the CIDR blocks of all public subnets"
  value       = { for k, v in aws_subnet.subnet : k => v.cidr_block }
}

output "public_subnet_availability_zone" {
  description = "the Availability Zones of all public subnets"
  value       = { for k, v in aws_subnet.subnet : k => v.availability_zone }
}

output "internet_gateway_id" {
  description = "the ID of the Internet Gateway"
  value       = aws_internet_gateway.gw.id
}

output "routing_table_id" {
  description = "the ID of the route table"
  value       = aws_route_table.route.id
}
