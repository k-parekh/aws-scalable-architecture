module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.project_name}-eks"
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  ################################
  # IAM (Explicit & Least Privilege)
  ################################
  create_iam_role = false
  iam_role_arn    = aws_iam_role.eks_cluster_role.arn

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false

  eks_managed_node_groups = {
    default = {
      create_iam_role = false
      iam_role_arn    = aws_iam_role.eks_node_role.arn

      instance_types = ["m6i.large"]
      min_size       = 2
      max_size       = 10
      desired_size   = 3
    }
  }

  tags = local.tags
}
