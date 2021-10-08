output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "ARN do Bucket do S3"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "Nome da tabela do DynamoDB"
}