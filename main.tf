data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
  load_config_file       = false
}

module "eks" {
  source  = "app.terraform.io/mfonseca-org/eks/aws"
  version = "16.1.4"
  subnets = var.subnets
  cluster_version = var.cluster_version
  vpc_id  = var.vpc_id
  cluster_name = var.cluster_name

  worker_groups = [
    {
      instance_type = "m4.large"
      asg_max_size  = 5
    }
  ]
}