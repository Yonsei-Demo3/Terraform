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

variable "public_subnet_cidr2" {
  description = "두번째 퍼블릭 서브넷 IP 대역"
  type        = string
  default     = "10.10.2.0/24"
}

variable "private_subnet_cidr" {
  description = "프라이빗 서브넷 IP 대역"
  type        = string
  default     = "10.10.3.0/24"
}

variable "private_subnet_cidr2" {
  description = "두번째 프라이빗 서브넷 IP 대역"
  type        = string
  default     = "10.10.4.0/24"
}

# --- EC2 변수 추가 ---
variable "ec2_instance_type" {
  description = "API 서버 인스턴스 타입"
  type        = string
  default     = "t3.micro"
}

variable "ec2_ami_id" {
  description = "API 서버가 사용할 AMI ID (Ubuntu 22.04 LTS, ap-northeast-2)"
  type        = string
  # (참고) 이 값은 AWS에서 'Ubuntu 22.04 LTS (HVM), amd64' 서울 리전 AMI ID입니다.
  default     = "ami-0a71e3eb8b23101ed"
}

variable "ec2_key_name" {
  description = "AWS에 등록된 EC2 키 페어 이름"
  type        = string
  # (default 없음, tfvars에서 꼭 입력하도록 강제)
}

#--- RDS 변수 추가 ---
variable "db_name" {
  description = "RDS에 생성할 데이터베이스 이름"
  type        = string
  default     = "sai_db"
}

variable "db_username" {
  description = "RDS 데이터베이스 접속용 사용자 이름"
  type        = string
  default     = "root"
}

variable "db_password" {
  description = "RDS 데이터베이스 접속용 비밀번호"
  type        = string
  sensitive   = true
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "sai-final-bucket-asdfasdf"
}

variable "environment" {
  description = "The environment"
  type        = string
  default     = "dev"
}