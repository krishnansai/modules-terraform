resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "public_1" {
    vpc_id     = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr_block_1
    availability_zone = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.project_name}-public-subnet-1"
    }
}

resource "aws_subnet" "public_2" {
    vpc_id     = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr_block_2
    availability_zone = data.aws_availability_zones.available.names[1]
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.project_name}-public-subnet-2"
    }
}   

resource "aws_subnet" "private_1" {
    vpc_id     = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr_block_1
    availability_zone = data.aws_availability_zones.available.names[0]
    tags = {
        Name = "${var.project_name}-private-subnet-1"
    }
}

resource "aws_subnet" "private_2" {
    vpc_id     = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr_block_2
    availability_zone = data.aws_availability_zones.available.names[1]
    tags = {
        Name = "${var.project_name}-private-subnet-2"
    }
}

resource "aws_subnet" "private_3" {
    vpc_id     = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr_block_3
    availability_zone = data.aws_availability_zones.available.names[0]
    tags = {
        Name = "${var.project_name}-private-subnet-3"
    }
}
resource "aws_subnet" "private_4" {
    vpc_id     = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr_block_4
    availability_zone = data.aws_availability_zones.available.names[1]
    tags = {
        Name = "${var.project_name}-private-subnet-4"
    }
}

resource "aws_route_table" "public" {
x  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-public-route-table"
  }
}

resource "aws_route" "public" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_2.id
  tags = {
    Name        = "${var.project_name}-nat-gateway"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-private-route-table"
  }
}

resource "aws_route" "private" {
  route_table_id = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_3" {
  subnet_id      = aws_subnet.private_3.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_4" {
  subnet_id      = aws_subnet.private_4.id
  route_table_id = aws_route_table.private.id
}


