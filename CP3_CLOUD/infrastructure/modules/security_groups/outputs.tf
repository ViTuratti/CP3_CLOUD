# Outputs
output "alb_sg_id" {
  description = "ID do Security Group do ALB"
  value       = aws_security_group.alb_sg.id
}

output "webtier_sg_id" {
  description = "ID do Security Group do Web Tier"
  value       = aws_security_group.webtier_sg.id
}