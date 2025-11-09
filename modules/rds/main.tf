# terraform/modules/rds/main.tf

# --- 1. DB 서브넷 그룹 생성 ---
# (새 서브넷을 만들지 않고, 'vpc' 모듈에서 만든 'public_subnet_id'를
#  var.public_subnet_id로 전달받아 그룹으로 묶어줍니다.)
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.project_name}-rds-subnet-group"
  subnet_ids = [var.public_subnet_id, var.public_subnet_id2] # (EC2와 동일한 서브넷 ID 사용)

  tags = {
    Name = "${var.project_name}-rds-subnet-group"
  }
}

# --- 2. RDS (MySQL) 인스턴스 생성 ---
resource "aws_db_instance" "rds_mysql" {
  # --- 사양 (Free Tier) ---
  allocated_storage = 20
  storage_type      = "gp2"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"

  # --- 자격 증명 (루트에서 전달받음) ---
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  # --- 네트워크 설정 (가장 중요) ---
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [var.rds_sg_id] # ('security' 모듈에서 만든 rds_sg ID)

  # 로컬 PC에서 접속할 수 있도록 공인 IP 할당
  publicly_accessible = true

  # 개발/테스트용으로, 삭제 시 스냅샷을 남기지 않아 삭제가 빠름
  skip_final_snapshot = true

  tags = {
    Name = "${var.project_name}-rds-mysql"
  }
}