variable "project_name" {
  description = "태그에 사용할 프로젝트 이름 (루트에서 전달받음)"
  type        = string
}

variable "vpc_id" {
  description = "EC2가 생성될 VPC의 ID (vpc 모듈에서 전달받음)"
  type        = string
}

variable "subnet_id" {
  description = "EC2가 생성될 서브넷 ID (vpc 모듈에서 전달받음)"
  type        = string
}


variable "instance_type" {
  description = "EC2 인스턴스 타입 (e.g., t3.micro)"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "EC2가 사용할 Amazon Machine Image ID"
  type        = string
}

variable "sg_id" {
  description = "보안 그룹 ID (security 모듈에서 전달받음)"
  type        = string
}


variable "ec2_key_name" {
  description = "EC2 접속용 SSH 키 페어 이름"
  type        = string
}