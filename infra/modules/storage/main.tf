resource "local_file" "bucket" {
  filename = "storage_bucket.txt"

  content = <<EOF
Bucket Name : ${var.bucket_name}
EOF
}
