# modules/security_groups/main.tf

# Grupo de Segurança para o ALB
resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Permitir trafego HTTP de entrada"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

# Grupo de Segurança para o Web Tier
resource "aws_security_group" "webtier_sg" {
  name        = "webtier_sg"
  description = "Permitir trafego HTTP do ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}


