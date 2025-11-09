---
name: "🏗️ Terraform 인프라 변경 요청"
about: "Changes about infra"
title: "[Terraform] "
labels: "infrastructure"
assignees: ""
---

## 1. 🎯 변경 목적 (What & Why)

(무엇을 왜 변경해야 하는지 자세히 설명해 주세요.)

* (e.g., API 서버 배포를 위해 EC2 인스턴스 추가)
* (e.g., RDS 인스턴스 타입을 t3.micro에서 t3.small로 변경)

<br>

## 2. 📝 변경할 리소스 (Resources)

(변경이 발생할 Terraform 모듈이나 리소스를 명시해 주세요.)

* **모듈:** `modules/ec2`
* **리소스:** `aws_instance.api_server`

<br>

## 3. ⚠️ 잠재적 위험 (Risk)

(이 변경으로 인해 발생할 수 있는 잠재적 위험이나 중단 가능성을 적어주세요.)

* (e.g., RDS 인스턴스 변경으로 인해 DB 중단 발생 예상)
* (e.g., 특이사항 없음. 신규 리소스 추가임.)

<br>

