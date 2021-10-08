output "alb_dns_name" {
  value       = aws_lb.lb-t12638.dns_name
  description = "DNS do Load Balancer"
}