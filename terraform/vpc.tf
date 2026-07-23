# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true # needs for rds
  enable_dns_support   = true # needs for rds
}

resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_block
  map_public_ip_on_launch = true # each public IP addr should have associate public IP addr
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_block
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "internet gw"
  }
}

# resource "aws_eip" "nat" {
#   domain = "vpc"

#   tags = {
#     Name = "nat-eip"
#   }
# }

#NAT Gateway 
# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.public1.id

#   depends_on = [
#     aws_internet_gateway.gw
#   ]

#   tags = {
#     Name = "nat-gateway"
#   }
# }


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_nat_gateway.nat.id # Private Route table attaches to NAT Gateway
#   }

#   tags = {
#     Name = "private-rt"
#   }
# }