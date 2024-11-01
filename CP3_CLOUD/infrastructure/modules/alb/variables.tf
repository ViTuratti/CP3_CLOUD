# modules/alb/variables.tf

variable "alb_name" {
  description = "Nome do Application Load Balancer"
  type        = string
}

variable "internal" {
  description = "Determina se o ALB é interno ou externo"
  type        = bool
  default     = false
}

variable "security_group_ids" {
  description = "IDs dos grupos de segurança associados ao ALB"
  type        = list(string)
}

variable "subnet_ids" {
  description = "IDs das subnets onde o ALB será criado"
  type        = list(string)
}

variable "target_group_name" {
  description = "Nome do Target Group do ALB"
  type        = string
}

variable "target_group_port" {
  description = "Porta do Target Group"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocolo do Target Group"
  type        = string
  default     = "HTTP"
}

variable "vpc_id" {
  description = "ID da VPC onde o Target Group será criado"
  type        = string
}

variable "listener_port" {
  description = "Porta do Listener do ALB"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "Protocolo do Listener do ALB"
  type        = string
  default     = "HTTP"
}

variable "health_check_path" {
  description = "Caminho para o Health Check"
  type        = string
  default     = "/"
}

variable "health_check_protocol" {
  description = "Protocolo para o Health Check"
  type        = string
  default     = "HTTP"
}

variable "health_check_interval" {
  description = "Intervalo do Health Check em segundos"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Timeout do Health Check em segundos"
  type        = number
  default     = 5
}

variable "health_check_healthy_threshold" {
  description = "Número de Health Checks bem-sucedidos antes de considerar a instância saudável"
  type        = number
  default     = 5
}

variable "health_check_unhealthy_threshold" {
  description = "Número de Health Checks falhos antes de considerar a instância não saudável"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags para os recursos do ALB"
  type        = map(string)
  default     = {}
}
