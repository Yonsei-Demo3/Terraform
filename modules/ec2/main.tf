
resource "aws_iam_role" "this" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.project_name}-ec2-instance-profile"
  role = aws_iam_role.this.name
}

# ---  EC2 인스턴스 (서버) 생성 ---
resource "aws_instance" "api_server" {
  ami           = var.ami_id      # (루트에서 전달받음)
  instance_type = var.instance_type # (루트에서 전달받음)

  # (VPC 모듈의 결과물 + 이 파일 1번에서 만든 방화벽)
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.sg_id]
  
  # (중요) EC2에 접속할 SSH 키 이름
  key_name                    = var.ec2_key_name # (variables.tf에 추가할 변수)

  iam_instance_profile        = aws_iam_instance_profile.this.name
  
  # (서버 부팅 시 실행할 스크립트 - 예시)
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y default-jre # (e.g., Java 설치)
              EOF

  tags = {
    Name = "${var.project_name}-api-server"
  }
}