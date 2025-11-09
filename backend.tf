terraform {
  # 앞으로 나의 '상태 파일(뇌)'은 S3에 저장하고, 
  # 잠금(Lock)'은 DynamoDB를 사용하겠다"라고 선언합니다.
  backend "s3" {
    bucket = "sai-tfstate-yonsei"

    # S3 버킷 안에 저장될 상태 파일의 이름입니다.
    # "dev" 폴더에 "terraform.tfstate"라는 이름으로 저장됩니다.
    key = "dev/terraform.tfstate"

    #S3 버킷을 만든 리전 (e.g., 서울)
    region = "ap-northeast-2"

    #1단계에서 만든 DynamoDB 테이블 이름을 정확히 입력하세요.
    dynamodb_table = "sai-terraform-lock"

    #S3에 저장할 때 암호화합니다.
    encrypt = true
  }
}