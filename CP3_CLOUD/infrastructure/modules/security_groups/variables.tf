# modules/security_groups/variables.tf

# ID da VPC onde os Security Groups serão criados
variable "vpc_id" {
  description = "ID da VPC onde os Security Groups serão criados"
  type        = string
}

# Tags a serem aplicadas aos Security Groups
variable "tags" {
  description = "Tags para os Security Groups"
  type        = map(string)
  default     = {}
}
