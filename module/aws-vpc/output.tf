output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_1" {
  description = "The ID of public subnet 1"
  value       = aws_subnet.public["public-1"].id
}

output "public_subnet_2" {
  description = "The ID of public subnet 2"
  value       = aws_subnet.public["public-2"].id
}

output "public_subnet_3" {
  description = "The ID of public subnet 3"
  value       = aws_subnet.public["public-3"].id
}

output "private_subnet_1" {
  description = "The ID of private subnet 1"
  value       = aws_subnet.private["private-1"].id
}

output "private_subnet_2" {
  description = "The ID of private subnet 2"
  value       = aws_subnet.private["private-2"].id
}

output "private_subnet_3" {
  description = "The ID of private subnet 3"
  value       = aws_subnet.private["private-3"].id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

