output "db_endpoint" {
  description = "RDS 데이터베이스 엔드포인트"
  value       = aws_db_instance.rds_mysql.endpoint
  
}