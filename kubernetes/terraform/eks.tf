module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = var.service

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = local.default_tags
}

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
      principal_arn = "arn:aws:iam::${data.aws_caller_identity.this.account_id}:root"
      policy_associations = {
        default = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 3
      desired_size = 1

      attach_cluster_primary_security_group = true
      instance_types                        = ["t3.small"]
      capacity_type                         = "ON_DEMAND"

      subnet_ids = module.vpc.private_subnets

      iam_role_additional_policies = {
        ecr = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
        ssm = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      }
    }
  }

  addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
    eks-pod-identity-agent = {
      before_compute = true
    }
  }

  tags = local.default_tags
}
