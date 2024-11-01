# outputs.tf

output "alb_dns_name" {
  description = "DNS do Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "target_group_arn" {
  description = "ARN do Target Group do ALB"
  value       = module.alb.target_group_arn
}
