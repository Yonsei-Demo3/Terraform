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


resource "aws_s3_bucket_cors_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  cors_rule {
    # 모든 메서드 허용
    allowed_methods = ["PUT", "POST", "GET", "HEAD", "DELETE"]
    allowed_origins = ["*"] 
    allowed_headers = ["*"]
    
    # ★ 중요: 프론트엔드가 업로드 후 ETag 확인하려면 이거 꼭 있어야 함
    expose_headers  = ["ETag"] 
    max_age_seconds = 3000
  }
}

# 5. S3 버킷 정책 (EC2 접근 허용)
resource "aws_s3_bucket_policy" "main_policy" {
  bucket = aws_s3_bucket.this.id

  depends_on = [aws_s3_bucket_public_access_block.this] 

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.this.arn}/*"
        },
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