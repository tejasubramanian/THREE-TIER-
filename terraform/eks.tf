module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  enable_irsa = true

  # Adds the identity running Terraform as a cluster admin via an EKS access
  # entry. This replaces the old aws-auth ConfigMap mechanism (removed in v20).
  enable_cluster_creator_admin_permissions = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Manage the core add-ons instead of the self-managed bootstrap versions.
  bootstrap_self_managed_addons = false
  cluster_addons = {
    coredns    = {}
    kube-proxy = { before_compute = true }
    vpc-cni    = { before_compute = true }
  }

  eks_managed_node_group_defaults = {
    ami_type = "AL2023_x86_64_STANDARD"
  }

  eks_managed_node_groups = {
    general = {
      desired_size   = 2
      min_size       = 1
      max_size       = 3
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
      labels = {
        role = "general"
      }
    }
  }


  tags = {
    Environment = "dev"
  }
}

