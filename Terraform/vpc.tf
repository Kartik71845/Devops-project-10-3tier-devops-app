resource "aws_vpc" "main" { # main vpc
  cidr_block = "10.0.0.0/16"
  tags = {
    Name        = "tf-vpc"
    Environment = "dev"
    Project = "aws-3tier"
  }
}

resource "aws_subnet" "public" { # public subnet
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "tf-public-subnet"
    Environment = "dev"
    Project = "aws-3tier"
  }
}

resource "aws_internet_gateway" "igw" { # igw for internet access
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "tf-igw"
    Environment = "dev"
    Project = "aws-3tier"
  }
}

resource "aws_route_table" "public_route" { # route table for public subnet
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "tf-public-rt"
    Environment = "dev"
    Project = "aws-3tier"
  }
}

resource "aws_route_table_association" "public_association" { # associate route table with public subnet   
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_subnet" "private" { # private subnet
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "tf-private-subnet-1"
    Environment = "dev"
    Project = "aws-3tier"
  }
}

resource "aws_eip" "nat" { # elastic ip for nat gateway
  domain = "vpc"
  tags = {
    Name        = "tf-nat-eip"
    Environment = "dev"
    Project     = "aws-3tier"
  }
}

resource "aws_nat_gateway" "nat" { # nat gateway for private subnet
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "tf-nat-gateway"
    Environment = "dev"
    Project = "aws-3tier"
  }
}


resource "aws_subnet" "private_2" {          # second private subnet
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"
    tags = {
        Name = "tf-private-subnet-2"
        Environment = "dev"
        Project = "aws-3tier"
    }
}

resource "aws_route_table" "private_route" { # route table for private subnet
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "tf-private-rt"
    Environment = "dev"
    Project = "aws-3tier"
  }
}

resource "aws_route_table_association" "private_association_1" { # associate route table with private subnet   
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_association_2" { # associate route table with second private subnet   
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_subnet" "public_subnet1" { # public subnet for load balancer
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "tf-public-subnet-lb"
    Environment = "dev"
    Project = "aws-3tier"
  }
}

resource "aws_route_table_association" "public_lb_association" { # associate route table with public subnet for load balancer   
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route.id
}