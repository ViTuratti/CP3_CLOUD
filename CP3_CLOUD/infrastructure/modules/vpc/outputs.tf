# Outputs
output "vpc_id" {
  description = "ID da VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  description = "IDs das Subnets Públicas"
  value       = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  description = "IDs das Subnets Privadas"
  value       = aws_subnet.private_subnet[*].id
}