# RDS PostgreSQL Instance in Private Subnets
resource "aws_db_instance" "postgres" {
  db_name           = "mydatabase"
  allocated_storage = 20
  engine            = "postgres"
  engine_version    = "16.4"        # Adjust based on your requirements
  instance_class    = "db.t3.micro" # Choose instance size as needed
  db_subnet_group_name   = aws_db_subnet_group.education.name

  username             = "vturatti"
  password             = "prova123456"
  parameter_group_name = "default.postgres16"

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}


resource "aws_db_subnet_group" "education" {
  name       = "education"
  subnet_ids = module.vpc.private_subnet_ids

  tags = {
    Name = "Education"
  }
}


 resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  vpc_id      = module.vpc.vpc_id
  description = "Allow database access"

  # Example ingress rule for PostgreSQL (port 5432)
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"] # Restrict to the VPC range or add specific access if needed
  }

  # Egress rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}