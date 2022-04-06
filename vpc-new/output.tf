output "VPC_Id" {
    value = aws_vpc.test1-vpc.id
}

output "pub-subnet-id" {
    value = aws_subnet.test1-pub-sub.id
}