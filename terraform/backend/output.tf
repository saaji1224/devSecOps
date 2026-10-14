output "terraform_state_bucket_name" {
  description = "S3 bucket name used for Terraform state storage"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "terraform_state_bucket_arn" {
  description = "S3 bucket ARN"
  value       = aws_s3_bucket.terraform_state.arn
}

output "terraform_lock_table_name" {
  description = "DynamoDB table name used for state locking"
  value       = aws_dynamodb_table.terraform_lock.name
}

output "terraform_lock_table_arn" {
  description = "DynamoDB table ARN"
  value       = aws_dynamodb_table.terraform_lock.arn
}   
