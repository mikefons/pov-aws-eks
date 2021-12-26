module "eks" {
  source  = "app.terraform.io/mfonseca-org/eks/aws"
  version = "16.1.3"
  subnets = var.subnets
  cluster_version = var.cluster_version
  vpc_id  = var.vpc_id
  cluster_name = var.cluster_name
}