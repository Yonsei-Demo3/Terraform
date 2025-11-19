variable "project_name" {
    description = "프로젝트 이름"
    type        = string
}

variable "subnet_ids" {
    description = "Redis가 배포될 서브넷 ID 목록"
    type        = list(string)
}

variable "redis_sg_id" {
    description = "Redis 보안 그룹 ID"
    type        = string
}