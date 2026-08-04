output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Map of public subnet names to their IDs"
  value       = { for k, v in aws_subnet.public : k => v.id }
}

output "internet_gateway_id" {
  description = "ID of the Internet gateway"
  value       = aws_internet_gateway.gw.id
}

output "route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}
