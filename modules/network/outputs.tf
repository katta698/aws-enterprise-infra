output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the main corporate VPC network"
}

output "public_subnets" {
  value       = aws_subnet.public[*].id
  description = "A list of the generated public subnet infrastructure IDs"
}

output "private_subnets" {
  value       = aws_subnet.private[*].id
  description = "A list of the generated private isolation subnet IDs"
}
