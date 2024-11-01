# modules/ec2/variables.tf

variable "ami" {
  description = "AMI ID para as instâncias EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "public_subnet_ids" {
  description = "IDs das subnets públicas"
  type        = list(string)
}

variable "webtier_sg_id" {
  description = "ID do grupo de segurança do web tier"
  type        = string
}

variable "target_group_arn" {
  description = "ARN do Target Group do ALB"
  type        = string
}

variable "desired_capacity" {
  description = "Capacidade desejada do ASG"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Tamanho máximo do ASG"
  type        = number
  default     = 5
}

variable "min_size" {
  description = "Tamanho mínimo do ASG"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags para o ASG"
  type        = map(string)
  default     = {}
}


variable "user_data" {
  description = "boostrap script for nginx"
  type        = string
}
