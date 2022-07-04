# Create VPC
# terraform aws create vpc
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc-cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "Test VPC ${var.env}"
  }
}
data "aws_availability_zones" "az" {}
# Create public subnets for all  AZ in select regions
resource "aws_subnet" "my-public-subnet" {
  count                   = length(data.aws_availability_zones.az.names)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "168.20.${10 + count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags {
    Name = "my-public-subnet-${count.index}"
  }
}

# Create private subnets for all  AZ in select regions
resource "aws_subnet" "private_subnet" {
  count                   = length(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.test-vpc.id
  cidr_block              = "10.20.${20 + count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags {
    Name = "my-private-subnet${count.index}"
  }
}
# Create Internet Gateway and Attach it to VPC
# terraform aws create internet gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id    = aws_vpc.vpc.id

  tags      = {
    Name    = "IGW-${var.env}"
  }
}

# Create Route Table and Add Public Route
# terraform aws create route table
resource "aws_route_table" "public-route-table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags       = {
    Name     = "Public Route Table"
  }
}

# Associate Public Subnet 1 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-association" {
  subnet_id           = aws_subnet.my-public-subnet.id
  route_table_id      = aws_route_table.public-route-table.id
}