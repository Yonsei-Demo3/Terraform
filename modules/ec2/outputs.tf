output "public_ip" {
  description = "EC2 인스턴스의 공인 IP 주소"
  value       = aws_instance.api_server.public_ip
}