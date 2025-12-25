module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "alb-sg"
  description = "ALB security group"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = ["https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules = ["all-all"]

  tags = local.tags
}
