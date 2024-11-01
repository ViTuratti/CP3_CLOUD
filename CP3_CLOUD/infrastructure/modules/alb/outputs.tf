# modules/alb/outputs.tf

output "alb_arn" {
  description = "ARN do Application Load Balancer"
  value       = aws_lb.external_alb.arn
}

output "alb_dns_name" {
  description = "DNS do Application Load Balancer"
  value       = aws_lb.external_alb.dns_name
}

output "target_group_arn" {
  description = "ARN do Target Group do ALB"
  value       = aws_lb_target_group.external_group.arn
}