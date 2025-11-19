# terraform/modules/vpc/variables.tf

variable "project_name" {
  description = "태그에 사용할 프로젝트 이름"
  type        = string
}

variable "aws_region" {
  description = "배포할 리전"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC가 사용할 IP 대역"
  type        = string
}

variable "public_subnet_cidr" {
  description = "퍼블릭 서브넷 IP 대역"
  type        = string
}

variable "public_subnet_cidr2" {
  description = "두번째 퍼블릭 서브넷 IP 대역"
  type        = string
}

variable "private_subnet_cidr" {
  description = "프라이빗 서브넷 IP 대역"
  type        = string
}

variable "private_subnet_cidr2" {
  description = "두번째 프라이빗 서브넷 IP 대역"
  type        = string
}