output "alb_dns_name" {
  description = "Application Load Balancer의 DNS 이름"
  value       = aws_lb.this.dns_name
}

#추후 도메인 연결에 필요
output "alb_zone_id" {
  description = "Application Load Balancer의 호스팅 영역 ID"
  value       = aws_lb.this.zone_id
}

output "alb_arn" {
  description = "Application Load Balancer의 ARN"
  value       = aws_lb.this.arn
}


output "api_target_group_arn" {
  description = "API 타겟 그룹 ARN"
  value       = aws_lb_target_group.api_tg.arn
}

output "socket_target_group_arn" {
  description = "소켓 타겟 그룹 ARN"
  value       = aws_lb_target_group.socket_tg.arn
}
