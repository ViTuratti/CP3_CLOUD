# modules/vpc/main.tf

# Criação da VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# Criação das Subnets Públicas
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr[count.index]
  count                   = length(var.public_subnet_cidr)
  map_public_ip_on_launch = true
  availability_zone       = var.AZ[count.index]

  tags = {
    Name = "Public_Subnet_${count.index + 1}"
  }
}

# Criação das Subnets Privadas
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr[count.index]
  count             = length(var.private_subnet_cidr)
  availability_zone = var.AZ[count.index]

  tags = {
    Name = "Private_Subnet_${count.index + 1}"
  }
}

# Criação do Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "tf_igw"
  }
}

# Criação do Elastic IP para o NAT Gateway
resource "aws_eip" "eip_nat_gateway" {
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "EIP"
  }
}

# Criação do NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  connectivity_type = "public"
  subnet_id         = aws_subnet.public_subnet[0].id
  allocation_id     = aws_eip.eip_nat_gateway.id

  tags = {
    Name = "NAT_GW"
  }
}

# Criação da Tabela de Rotas Pública
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

# Criação da Tabela de Rotas Privada
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "private_route_table"
  }
}

# Associação da Tabela de Rotas às Subnets Públicas
resource "aws_route_table_association" "public_route_assoc" {
  subnet_id      = aws_subnet.public_subnet[count.index].id
  count          = length(aws_subnet.public_subnet)
  route_table_id = aws_route_table.public_route_table.id
}

# Associação da Tabela de Rotas às Subnets Privadas
resource "aws_route_table_association" "private_route_assoc" {
  subnet_id      = aws_subnet.private_subnet[count.index].id
  count          = length(aws_subnet.private_subnet)
  route_table_id = aws_route_table.private_route_table.id
}

