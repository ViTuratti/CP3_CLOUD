# variables.tf

# Região da AWS
variable "region" {
  description = "Região da AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1" # Alterar conforme necessário
}

# Chave de Acesso AWS
variable "access_key" {
  description = "Chave de acesso da AWS"
  type        = string
  sensitive   = true
}

# Chave Secreta AWS
variable "secret_key" {
  description = "Chave secreta da AWS"
  type        = string
  sensitive   = true
}

# Token de Sessão AWS (para credenciais temporárias)
variable "session_token" {
  description = "Token de sessão da AWS para credenciais temporárias"
  type        = string
  sensitive   = true
}


variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"

}

variable "public_subnet_cidr" {
  description = "CIDR das Subnets Públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr" {
  description = "CIDR das Subnets Privadas"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "AZ" {
  description = "Zonas de Disponibilidade"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "ami" {
  description = "AMI ID para as instâncias EC2"
  type        = string
  default     = "ami-0c94855ba95c71c99"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "user_data" {
  description = "Script de inicialização para as instâncias EC2"
  type        = string
  default     = <<-EOF
                #!/bin/bash
                # Atualizar todos os pacotes instalados
                yum update -y

                # Instalar o Nginx
                amazon-linux-extras install nginx1 -y

                # Iniciar o serviço Nginx
                systemctl start nginx

                # Habilitar o Nginx para iniciar no boot
                systemctl enable nginx

                # Criar uma página inicial personalizada (opcional)
                echo "<h1>Bem-vindo ao Nginx no Amazon Linux 2!</h1>" > /usr/share/nginx/html/index.html
                EOF
}