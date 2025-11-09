variable "project_name" {
  description = "프로젝트명"
  type        = string
  default     = "sai-project"
}

variable "aws_region" {
  description = "AWS 리전"
  type        = string
  default     = "ap-northeast-2"
}

# --- VPC 변수 ---
variable "vpc_cidr" {
  description = "VPC가 사용할 IP 대역"
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidr" {
  description = "퍼블릭 서브넷 IP 대역"
  type        = string
  default     = "10.10.1.0/24"
}