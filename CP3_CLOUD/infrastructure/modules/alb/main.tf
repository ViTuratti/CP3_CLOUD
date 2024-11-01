# modules/alb/main.tf

# Criação do Application Load Balancer (ALB)
resource "aws_lb" "external_alb" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  tags = var.tags
}

# Criação do Target Group para o ALB
resource "aws_lb_target_group" "external_group" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id

  # health_check {
  #   path                = var.health_check_path
  #   protocol            = var.health_check_protocol
  #   interval            = var.health_check_interval
  #   timeout             = var.health_check_timeout
  #   healthy_threshold   = var.health_check_healthy_threshold
  #   unhealthy_threshold = var.health_check_unhealthy_threshold
  # }

  tags = var.tags
}

# Criação do Listener do ALB
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.external_alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.external_group.arn
  }
}
