variable "project_name" {
    description = "프로젝트 이름"
    type        = string
    default     = "sai-project"
}

variable "vpc_id" {
    description = "ALB가 생성될 VPC의 ID"
    type        = string
}

variable "subnet_ids" {
    description = "ALB가 생성될 서브넷 ID 목록"
    type        = list(string)
}

variable "alb_sg_id" {
    description = "ALB에 할당할 보안 그룹 ID"
    type        = string
}

variable "api_instance_id" {
    description = "API 서버 인스턴스 ID"
    type        = string
  
}

variable "socket_instance_id" {
    description = "Socket 서버 인스턴스 ID"
    type        = string
}