resource "aws_vpc" "main" {

  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-${var.environment}-vpc"
  }
}



resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}


# Public Subnets
resource "aws_subnet" "public_subnet_1" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-1"

    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "public_subnet_2" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-2"

    "kubernetes.io/role/elb" = "1"
  }
}


# Private Subnets
resource "aws_subnet" "private_app_subnet_1" {

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_app_subnet_1_cidr
  availability_zone = "ap-south-1a"

  tags = {
    Name = "${var.project_name}-private-app-1"

    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "private_app_subnet_2" {

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_app_subnet_2_cidr
  availability_zone = "ap-south-1b"

  tags = {
    Name = "${var.project_name}-private-app-2"

    "kubernetes.io/role/internal-elb" = "1"
  }
}


# Private subnet for DB 
resource "aws_subnet" "private_db_subnet_1" {

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_db_subnet_1_cidr
  availability_zone = "ap-south-1a"

  tags = {
    Name = "${var.project_name}-private-db-1"
  }
}

resource "aws_subnet" "private_db_subnet_2" {

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_db_subnet_2_cidr
  availability_zone = "ap-south-1b"

  tags = {
    Name = "${var.project_name}-private-db-2"
  }
}


# Creating route table
resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# Route table association
resource "aws_route_table_association" "public_1" {

  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {

  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public.id
}

