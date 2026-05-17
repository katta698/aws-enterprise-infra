output "ec2_profile_name" {
  value       = aws_iam_instance_profile.ec2_profile.name
  description = "The identification profile token mapped to running compute cluster instances"
}

output "backup_role_arn" {
  value       = aws_iam_role.backup_role.arn
  description = "The global execution role token assigned to handling lifecycle backup engines"
}
