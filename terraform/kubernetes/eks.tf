module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.service
  kubernetes_version = "1.34"

  endpoint_public_access                   = true
  enable_cluster_creator_admin_permissions = true

  compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  access_entries = {
    root = {
      principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      policy_arn    = "arn:aws:iam::aws:policy/AmazonEKSClusterAdminPolicy"
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # eks_managed_node_groups = {
  #   EKS_Node_Group = {
  #     min_size     = 1
  #     max_size     = 3
  #     desired_size = 1

  #     instance_types = ["t3.medium"]
  #     capacity_type  = "ON_DEMAND"

  #     subnet_ids = module.vpc.private_subnets
  #   }
  # }

  addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    eks-pod-identity-agent = {
      before_compute = true
      most_recent    = true
    }
  }

  tags = local.default_tags
}
