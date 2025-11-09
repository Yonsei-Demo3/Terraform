variable "project_name" {
  description = "태그에 사용할 프로젝트 이름 (루트에서 전달받음)"
  type        = string
}

variable "public_subnet_id" {
  description = "RDS가 생성될 서브넷 ID (vpc 모듈에서 전달받음)"
  type        = string
}

variable "rds_sg_id" {
    description = "RDS용 보안 그룹 ID (security 모듈에서 전달받음)"
    type        = string
}

variable "db_name" {
  description = "RDS에 생성할 데이터베이스 이름(루트에서 전달받음)"
  type        = string
  default     = "sai_db"
}

variable "db_username" {
  description = "RDS 데이터베이스 접속용 사용자 이름(루트에서 전달받음)"
  type        = string
  default     = "root"
}

variable "db_password" {
  description = "RDS 데이터베이스 접속용 비밀번호(루트에서 전달받음)"
  type        = string
  sensitive   = true
}