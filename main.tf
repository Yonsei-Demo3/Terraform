# --- 1. VPC 모듈 호출 ---
# "modules/vpc" 폴더에 있는 코드를 실행합니다.
# 루트의 'var.project_name' 값을 모듈의 'project_name' 변수로 전달합니다.
module "vpc" {
  source = "./modules/vpc" # (모듈 폴더 경로)

  # "파라미터 전달"
  # (모듈의 variables.tf) = (루트의 variables.tf)
  project_name       = var.project_name
  aws_region         = var.aws_region
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
}