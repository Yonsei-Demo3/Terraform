# 🏗️ SAI Infrastructure

> **SAI(사이)** 서비스의 AWS 인프라를 **Terraform(IaC)** 으로 관리하는 레포지토리입니다.

VPC, EC2, ALB, RDS, ElastiCache 등 전체 인프라를 코드로 정의하며, 모듈화된 구조로 재사용성과 유지보수성을 확보합니다.

---

## ☁️ 인프라 구성

```
                        ┌─────────────────────────────────────┐
                        │              AWS VPC                │
                        │                                     │
  [Client] ──► ALB ──► │  EC2 (Spring Boot)                  │
                        │  EC2 (Node.js + Socket.IO)          │
                        │       │              │              │
                        │      RDS           ElastiCache      │
                        │    (MySQL)          (Redis)         │
                        └─────────────────────────────────────┘
```

| 리소스 | 설명 |
|--------|------|
| **VPC** | 퍼블릭/프라이빗 서브넷 분리, 보안 그룹 설정 |
| **EC2** | Spring Boot API 서버 + Node.js 채팅 서버 |
| **ALB** | Application Load Balancer, 트래픽 라우팅 |
| **RDS (MySQL)** | 회원 정보, 채팅방 데이터 |
| **ElastiCache (Redis)** | Socket.IO Adapter, Spring ↔ Node.js Pub/Sub |

---

## ⚙️ 기술 스택

| 분류 | 기술 |
|------|------|
| IaC | Terraform |
| Cloud | AWS |
| State 관리 | S3 Remote Backend |
| State Lock | DynamoDB |

---

## 📁 디렉토리 구조

```
.
├── main.tf
├── variables.tf
├── outputs.tf
├── backend.tf          # S3 Remote Backend 설정
├── modules/
│   ├── vpc/            # VPC, 서브넷, 라우팅
│   ├── ec2/            # EC2 인스턴스
│   ├── alb/            # Application Load Balancer
│   ├── rds/            # MySQL RDS
│   └── elasticache/    # Redis ElastiCache
└── environments/
    └── prod/
```

---

## 🔍 기술적 의사결정

### Remote Backend: S3 + DynamoDB

**문제 상황**

초기에는 Terraform State 파일을 로컬에 저장했습니다. 팀원 간 State 불일치로 인프라 위험이 존재했고, "누가 먼저 apply 했는지"에 따라 인프라 상태가 달라지는 문제가 생길 수 있음을 확인했습니다.

**해결: S3 Remote Backend + DynamoDB Lock**

```hcl
terraform {
  backend "s3" {
    bucket = "sai-terraform-state"
    key    = "prod/terraform.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
```

- **S3**: 단일 State 파일을 팀 전체가 공유
- **DynamoDB**: `terraform apply` 동시 실행 방지 (State Lock)
- **encrypt**: State 파일 암호화로 민감 정보 보호


---

### 모듈화 구조 채택

리소스를 기능 단위 모듈로 분리해 재사용성과 유지보수성을 확보했습니다.

```hcl
module "vpc" {
  source = "./modules/vpc"
  cidr   = var.vpc_cidr
}

module "rds" {
  source     = "./modules/rds"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
}
```

각 모듈은 독립적으로 테스트 및 수정이 가능하며, 환경(dev/prod) 별로 변수만 달리하여 동일한 모듈을 재사용할 수 있습니다.

---

## 🚀 사용 방법

### 사전 준비

- AWS CLI 설정 (`aws configure`)
- Terraform 설치
- S3 버킷 및 DynamoDB 테이블 사전 생성

### 초기화 및 배포

```bash
# 초기화 (Backend 연결 포함)
terraform init

# 변경 사항 미리 확인
terraform plan

# 인프라 배포
terraform apply

# 인프라 전체 삭제
terraform destroy
```

### 주요 변수

`variables.tf` 또는 `terraform.tfvars`에서 설정합니다.

```hcl
region       = "ap-northeast-2"
env          = "prod"
db_password  = "YOUR_PASSWORD"
```

---

## 📌 관련 레포지토리

| 오가니제이션 | 설명 |
|------|------|
| [sai](https://github.com/Yonsei-Demo3) | 오가니제이션 |

---

## 👥 팀 정보

**프로젝트 기간**: 2025.09 ~ 2025.12  
**팀 구성**: 4명 (프론트엔드 2명, 백엔드 2명)
