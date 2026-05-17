output "alb_sg_id" {
  value       = aws_security_group.alb.id
  description = "The ID of the public application load balancer security group"
}

output "ec2_sg_id" {
  value       = aws_security_group.ec2.id
  description = "The ID of the private application compute server security group"
}

output "kms_key_arn" {
  value       = aws_kms_key.backup_key.arn
  description = "The absolute ARN mapping for the backup storage volume cryptographic key"
}
