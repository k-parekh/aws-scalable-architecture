module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"

  identifier = "${var.project_name}-aurora"

  engine         = "aurora-postgresql"
  major_engine_version = "15"
  instance_class = "db.r6g.large"
  family = "aurora-postgresql-15-2"

  allocated_storage = 20
  max_allocated_storage = 100

  db_subnet_group_name = module.vpc.database_subnet_group
  vpc_security_group_ids = []

  storage_encrypted = true
  multi_az          = true

  tags = local.tags
}
