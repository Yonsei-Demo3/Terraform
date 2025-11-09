# Terraform이 어떤 클라우드 공급자(Provider)를 다운로드해야 하는지 알려줍니다.
terraform {
  required_providers {
    # 우리는 "aws"를 사용할 것이고, 최신 버전을 사용합니다.
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # (가장 안정적인 최신 5.x 버전을 사용)
    }
  }
}

# AWS 공급자(Provider)의 기본 설정을 지정합니다.
provider "aws" {
  # 기본 리전을 서울(ap-northeast-2)로 설정합니다.
  region = "ap-northeast-2"
}