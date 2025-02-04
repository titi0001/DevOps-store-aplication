resource "aws_vpc" "store_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true # Habilita o suporte a DNS
  enable_dns_hostnames = true # Permite a atribuição de hostnames
  tags = {
    Name = "store-vpc"
  }
}

resource "aws_subnet" "store_subnet" {
  vpc_id                  = aws_vpc.store_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true # Para instâncias públicas receberem IP público automaticamente
  tags = {
    Name = "store-subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.store_vpc.id
  tags = {
    Name = "store-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.store_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "store-public-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.store_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
