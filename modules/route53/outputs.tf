output "name_servers" {
    description = "가비아에 등록할 네임서버 목록"
    value       = aws_route53_zone.main.name_servers
}