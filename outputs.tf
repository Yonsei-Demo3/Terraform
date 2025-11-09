output "vpc_id" {
  description = "생성된 VPC의 ID (루트에 보고)"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "생성된 퍼블릭 서브넷의 ID (루트에 보고)"
  value       = module.vpc.public_subnet_id
}

output "public_route_table_id" {
  description = "생성된 퍼블릭 라우트 테이블 ID (루트에 보고)"
  value       = module.vpc.public_route_table_id
}

output "api_server_public_ip" {
  description = "API 서버 (EC2)의 공인 IP 주소"
  value       = module.api_server.public_ip
}

output "rds_endpoint" {
  description = "RDS 데이터베이스 엔드포인트"
  value       = module.rds.database_endpoint
}