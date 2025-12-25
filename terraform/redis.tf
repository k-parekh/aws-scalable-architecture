resource "aws_elasticache_subnet_group" "redis" {
  name       = "${var.project_name}-redis-subnet"
  subnet_ids = module.vpc.private_subnets
}

resource "aws_elasticache_replication_group" "redis" {
  description = "Redis for cahching"
  replication_group_id = "${var.project_name}-redis"
  engine               = "redis"
  node_type            = "cache.r6g.large"
  num_cache_clusters   = 2

  subnet_group_name = aws_elasticache_subnet_group.redis.name
  automatic_failover_enabled = true
  transit_encryption_enabled = true
  at_rest_encryption_enabled = true

  tags = local.tags
}
