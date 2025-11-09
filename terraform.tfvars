# terraform/terraform.tfvars

# 'variables.tf'에서 선언한 변수들의 값을 지정합니다.
project_name = "sai-project-dev"
vpc_cidr     = "10.10.0.0/16"

# (나중에 RDS 마스터 비밀번호 같은 민감 정보를 여기에 추가할 것입니다)
# db_password = "MySecurePassword123!"