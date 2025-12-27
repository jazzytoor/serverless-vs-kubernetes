data "aws_caller_identity" "this" {}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_name
}

data "http" "iam_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/refs/heads/main/docs/install/iam_policy.json"
}
