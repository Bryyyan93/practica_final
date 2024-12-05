output "load_balancer_arn" {
  description = "ARN del Load Balancer"
  value       = aws_lb.main.arn
}

output "load_balancer_dns_name" {
  description = "DNS público del Load Balancer"
  value       = aws_lb.main.dns_name
}

output "target_group_arn" {
  description = "ARN del Target Group asociado al Load Balancer"
  value       = aws_lb_target_group.php_app.arn
}

output "listener_arn" {
  description = "ARN del Listener asociado al Load Balancer"
  value       = aws_lb_listener.http.arn
}
