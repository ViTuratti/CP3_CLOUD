# modules/ec2/main.tf

# Criação do Launch Template para o Auto Scaling
resource "aws_launch_template" "ec2_launch_template" {
  name_prefix   = "ec2-launch-template-"
  image_id      = var.ami
  instance_type = var.instance_type

  network_interfaces {
    security_groups             = [var.webtier_sg_id]
    associate_public_ip_address = true
  }

  user_data = base64encode(var.user_data)

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "AutoScaled-EC2"
    }
  }
}

# Criação do Grupo de Auto Scaling (ASG)
resource "aws_autoscaling_group" "asg" {
  name                 = "ec2-asg"
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = var.public_subnet_ids

  launch_template {
    id      = aws_launch_template.ec2_launch_template.id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]

  tag {
    key                 = "Name"
    value               = "AutoScaled-EC2"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Política de Escalonamento por Utilização de CPU
resource "aws_autoscaling_policy" "cpu_target_tracking" {
  name                   = "cpu_target_tracking_policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.asg.name

  estimated_instance_warmup = 300  # Tempo em segundos

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 70.0
  }
}
