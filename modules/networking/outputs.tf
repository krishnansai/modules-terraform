output "region" {
    value = var.region
}

output "project_name" {
    value = var.project_name
}

output "vpc_id" {
    value = aws_vpc.main.id
}

output "public_subnet_id_1" {
    value = aws_subnet.public_1.id
}

output "public_subnet_id_2" {
    value = aws_subnet.public_2.id
}

output "private_subnet_id_1" {
    value = aws_subnet.private_1.id
}

output "private_subnet_id_2" {
    value = aws_subnet.private_2.id
}

output "private_subnet_id_3" {
    value = aws_subnet.private_3.id
}

output "private_subnet_4" {
    value = aws_subnet.private_4.id
}

output "aws_internet_gateway" {
    value = aws_internet_gateway.main
}