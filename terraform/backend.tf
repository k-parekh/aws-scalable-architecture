terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-ct"
    key            = "eks-platform/terraform.tfstate"
    region         = "eu-north-1"
    use_lockfile   = true
    encrypt        = true
  }
}
