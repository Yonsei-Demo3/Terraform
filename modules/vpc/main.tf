#키워드(resource) "리소스 타입" "로컬 네임" {}
#
#
#

# --- 1. VPC 생성 ---
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr # (var.vpc_cidr는 이 모듈의 variables.tf에서 받아야 함)
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = { Name = "${var.project_name}-vpc" }
}

# --- 2. 인터넷 게이트웨이 ---
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.project_name}-igw" }
}

# --- 3. 퍼블릭 서브넷 ---
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true
  tags                    = { Name = "${var.project_name}-public-subnet" }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr2
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true
  tags                    = { Name = "${var.project_name}-public-subnet-2" }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "${var.aws_region}a"
  tags              = { Name = "${var.project_name}-private-subnet" }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr2
  availability_zone = "${var.aws_region}b"
  tags              = { Name = "${var.project_name}-private-subnet-2" }
}

# --- 4. 라우트 테이블 (Route Table) 생성 ---
# "퍼블릭 서브넷"이 사용할 '교통 규칙' (네비게이션)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  # (★핵심★)
  # "0.0.0.0/0" (모든 인터넷 트래픽)은
  # '인터넷 게이트웨이(대문)'로 가라는 규칙
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# --- 5. 라우트 테이블 연결 ---
# "방금 만든 '퍼블릭 서브넷'은 '퍼블릭 교통 규칙'을 따른다"
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rt.id
}