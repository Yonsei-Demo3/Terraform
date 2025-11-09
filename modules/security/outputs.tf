output "api_sg_id" {
  description = "API 서버 보안 그룹 ID"
  value       = aws_security_group.api_sg.id
}
