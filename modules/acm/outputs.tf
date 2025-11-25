output "aws_acm_certificate_arn" {
    description = "검증이 완료된 인증서 ARN"
    value = aws_acm_certificate_validation.this.certificate_arn
}