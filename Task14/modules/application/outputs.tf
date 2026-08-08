output "load_balancer_dns_name" {
  value       = aws_lb.applb.dns_name
  description = "DNS name of the load balancer"
}
