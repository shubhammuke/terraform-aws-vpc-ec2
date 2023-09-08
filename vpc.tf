provider "aws" {
  region = "ap-south-2"
}

// VPC Creation
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-Vpc"
  }
}

// Internet Gateway Creation
resource "aws_internet_gateway" "Web-igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-IGW"
  }
}

// Public Subnet Creation
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-2a"
  map_public_ip_on_launch = "true"
  
  tags = {
    Name = "public-SN"
  }
}

// Route Table Creation
resource "aws_route_table" "WebRT" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Web-igw.id
  }

  tags = {
    Name = "WebSrv-RT"
  }
}

// Route Table Association With Public Subnet Internet Connectivity
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.WebRT.id
}


// Security Group Creation
resource "aws_security_group" "WebSG" {
  name        = "WebSG"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-SG"
  }
}



