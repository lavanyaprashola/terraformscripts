provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "test1-vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_internet_gateway" "test1-igw" {
  vpc_id = aws_vpc.test1-vpc.id
}

resource "aws_subnet" "test1-pub-sub" {
  vpc_id = aws_vpc.test1-vpc.id
  cidr_block = var.Pub_cidr
  availability_zone = "us-west-2a"
}

resource "aws_subnet" "test1-priv-sub" {
  vpc_id = aws_vpc.test1-vpc.id
  cidr_block = var.Pri_cidr
  availability_zone = "us-west-2a"
}

resource "aws_route_table" "test1-pub-rtbl" {
  vpc_id = aws_vpc.test1-vpc.id
}

resource "aws_route_table" "test1-priv-rtbl" {
  vpc_id = aws_vpc.test1-vpc.id
}

resource "aws_route" "test1-pub-rt" {
  route_table_id = aws_route_table.test1-pub-rtbl.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.test1-igw.id
}


resource "aws_eip" "test1-eip" {
}

resource "aws_nat_gateway" "test1-nat" {
  allocation_id = aws_eip.test1-eip.id
  subnet_id = aws_subnet.test1-pub-sub.id
}

resource "aws_route" "test1-priv-rt" {
  route_table_id = aws_route_table.test1-priv-rtbl.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.test1-nat.id
}
