output "api_sg_id" {
  description = "API 서버 보안 그룹 ID"
  value       = aws_security_group.api_sg.id
}

output "rds_sg_id" {
  description = "RDS 보안 그룹 ID"
  value       = aws_security_group.rds_sg.id
}

output "socket_sg_id" {
  description = "Socket 서버 보안 그룹 ID"
  value       = aws_security_group.socket_sg.id
}

output "redis_sg_id" {
  description = "Redis 서버 보안 그룹 ID"
  value       = aws_security_group.redis_sg.id
}
