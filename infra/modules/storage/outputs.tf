output "bucket_name" {
  value       = aws_s3_bucket.assets.bucket
  description = "Name of the CloudNotes assets bucket"
}

output "bucket_arn" {
  value       = aws_s3_bucket.assets.arn
  description = "ARN of the CloudNotes assets bucket"
}