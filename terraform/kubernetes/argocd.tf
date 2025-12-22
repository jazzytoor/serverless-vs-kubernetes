resource "aws_eks_capability" "default" {
  cluster_name              = module.eks.cluster_name
  capability_name           = "argocd"
  type                      = "ARGOCD"
  role_arn                  = module.argocd.arn
  delete_propagation_policy = "RETAIN"

  configuration {
    argo_cd {
      aws_idc {
        idc_instance_arn = local.sso_instance_arn
      }
      namespace = "argocd"
      rbac_role_mapping {
        role = "EDITOR"
        identity {
          id   = aws_identitystore_group.default.group_id
          type = "SSO_GROUP"
        }
      }
    }
  }

  tags = local.default_tags
}
