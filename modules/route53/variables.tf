variable "domain_name" {
  description = "구입한 도메인 이름 (예: mydomain.com)"
  type        = string
}

variable "alb_dns_name" {
  description = "ALB 접속 주소 (API 연결용)"
  type        = string
}

variable "alb_zone_id" {
  description = "ALB Zone ID (API 연결용)"
  type        = string
}