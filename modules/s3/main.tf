resource "aws_s3_bucket" "this" {
    bucket = var.bucket_name
    force_destroy = true
    
    tags = {
        Name        = "${var.project_name}-s3-bucket"
        Environment = var.environment
    }
}

// 퍼블릭 액세스 차단
resource "aws_s3_bucket_public_access_block" "this" {
    bucket = aws_s3_bucket.this.id

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}



//ACL 사용하지 않음
resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.this.id

  # Public Access Block 설정이 먼저 적용된 후에 정책이 들어가야 에러가 안 남
  depends_on = [aws_s3_bucket_public_access_block.this]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"  # 전 세계 누구나
        Action    = "s3:GetObject" # 읽기만 가능 (업로드/삭제는 불가)
        Resource  = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_cors_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "DELETE"]
    allowed_origins = ["*"]
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

# 5. S3 버킷 정책 (EC2 접근 허용)
resource "aws_s3_bucket_policy" "allow_ec2" {
  bucket = aws_s3_bucket.this.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowEC2"
        Effect    = "Allow"
        Principal = { 
          AWS = var.ec2_iam_role_arn
        }
        Action    = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource  = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}