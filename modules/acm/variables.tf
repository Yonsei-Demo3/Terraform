variable "domain_name" {
    description = "인증서를 발급할 도메인 이름"
    type = string
}

variable "route53_zone_id" {
    description = "검증용 레코드를 생성할 Route53 Zone ID"
    type = string
}