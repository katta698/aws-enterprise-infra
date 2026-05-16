output "dev_s3_bucket_name" { value = aws_s3_bucket.dev_state.id }
output "dev_dynamodb_table_name" { value = aws_dynamodb_table.dev_locks.name }
output "prod_s3_bucket_name" { value = aws_s3_bucket.prod_state.id }
output "prod_dynamodb_table_name" { value = aws_dynamodb_table.prod_locks.name }
output "dev_gha_role_arn" { value = module.github_oidc.dev_gha_role_arn }
output "prod_gha_role_arn" { value = module.github_oidc.prod_gha_role_arn }
