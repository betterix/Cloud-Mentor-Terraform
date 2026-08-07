output "ssh_sg_id" {
  value       = aws_security_group.ssh_sg.id
  description = "ID of ssh security group"
}

output "public_http_sg_id" {
  value       = aws_security_group.public_http_sg.id
  description = "ID of the public HTTP security group"
}

output "private_http_sg_id" {
  value       = aws_security_group.private_http_sg.id
  description = "ID of the private HTTP security group"
}
