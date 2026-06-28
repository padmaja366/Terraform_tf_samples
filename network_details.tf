#contains vpc, subnets, igw and routing details
provider "aws" {
  region = "ap-southeast-1"
}
resource "aws_vpc" "example" {
  tags = {
    Name = "example_vpc"
  }
  cidr_block = "███████████"
}
resource "aws_subnet" "public-example-vpc" {
  vpc_id = aws_vpc.example.id
  availability_zone = "ap-southeast-1a"
  cidr_block = "███████████"
  tags = {
    Name = "public-subnet-example-vpc"
  }
}
resource "aws_internet_gateway" "igm-example" {
  vpc_id = aws_vpc.example.id
}
resource "aws_route_table" "public-route-example" {
  vpc_id = aws_vpc.example.id
  route {
    cidr_block = "███████████"
    gateway_id =  aws_internet_gateway.igm-example.id
  }
}
resource "aws_route_table_association" "public-association" {
  subnet_id = aws_subnet.public-example-vpc.id
  route_table_id = aws_route_table.public-route-example.id
}
