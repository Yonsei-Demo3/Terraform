output "vpc_id" {
  description = "생성된 VPC의 ID (루트에 보고)"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "생성된 퍼블릭 서브넷의 ID (루트에 보고)"
  value       = aws_subnet.public.id
}

output "public_subnet_id2" {
  description = "생성된 두번째 퍼블릭 서브넷의 ID (루트에 보고)"
  value       = aws_subnet.public2.id
}

output "public_route_table_id" {
  description = "생성된 퍼블릭 라우트 테이블 ID (루트에 보고)"
  value       = aws_route_table.public_rt.id
}