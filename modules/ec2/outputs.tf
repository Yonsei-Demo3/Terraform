output "public_ip" {
  description = "EC2 인스턴스의 공인 IP 주소"
  value       = aws_instance.api_server.public_ip
}

output "iam_role_arn" {
  description = "The ARN of the IAM role"
  value       = aws_iam_role.this.arn
}