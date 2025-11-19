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
  public_subnet_cidr2 = var.public_subnet_cidr2
  private_subnet_cidr = var.private_subnet_cidr
  private_subnet_cidr2 = var.private_subnet_cidr2
}

module "security" {
  source = "./modules/security"

  # VPC 모듈의 결과물(vpc_id)을 전달
  vpc_id       = module.vpc.vpc_id 
  project_name = var.project_name
}

# --- 2. API 서버 (EC2) 모듈 호출 ---
module "api_server" {
  source = "./modules/ec2"

  # 루트 변수 전달
  project_name  = var.project_name
  instance_type = var.ec2_instance_type
  ami_id        = var.ec2_ami_id

  # VPC 모듈의 '결과물'을 EC2 모듈의 '입력값'으로 전달
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id

  
  sg_id = module.security.api_sg_id

  ec2_key_name = var.ec2_key_name
}

module "socket_server" {
  source = "./modules/ec2"

  # 루트 변수 전달
  project_name  = var.project_name
  instance_type = var.ec2_instance_type
  ami_id        = var.ec2_ami_id

  # VPC 모듈의 '결과물'을 EC2 모듈의 '입력값'으로 전달
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id

  sg_id = module.security.socket_sg_id

  ec2_key_name = var.ec2_key_name
}

# --- 3. RDS 모듈 호출 ---
module "rds" {
  source = "./modules/rds"

  project_name       = var.project_name
  public_subnet_id   = module.vpc.public_subnet_id
  public_subnet_id2  = module.vpc.public_subnet_id2
  rds_sg_id          = module.security.rds_sg_id

  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
}

module "redis" {
  source = "./modules/redis"

  project_name       = var.project_name
  subnet_ids = [
    module.vpc.private_subnet_id,
    module.vpc.private_subnet_id2
  ]
  redis_sg_id        = module.security.redis_sg_id
}
