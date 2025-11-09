variable "project_name" {
  description = "태그에 사용할 프로젝트 이름 (루트에서 전달받음)"
  type        = string
}

variable "vpc_id" {
  description = "EC2가 생성될 VPC의 ID (vpc 모듈에서 전달받음)"
  type        = string
}