resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "${var.project_name}-redis-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.project_name}-redis-subnet-group"
  }
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id = "${var.project_name}-redis"
  description = "SAI Project Redis Cluster"
  node_type = "cache.t3.micro"
  port = 6379

  automatic_failover_enabled = false
  num_node_groups = 1
  replicas_per_node_group = 0

  subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids = [var.redis_sg_id]

  engine = "redis"
  engine_version = "7.0"
  parameter_group_name = "default.redis7"

  tags = {
    Name = "${var.project_name}-redis"
  }
}