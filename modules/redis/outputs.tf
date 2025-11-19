output "redis_endpoint" {
    description = "Redis 기본 노드 접속 주소"
    value       = aws_elasticache_replication_group.redis.primary_endpoint_address
}