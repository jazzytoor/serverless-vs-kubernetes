resource "aws_identitystore_group" "default" {
  display_name      = var.service
  description       = var.service
  identity_store_id = local.sso_instance_id
}

module "argocd" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role"

  name            = "AmazonEKSCapabilityArgoCDRole"
  use_name_prefix = false

  trust_policy_permissions = {
    TrustRoleAndServiceToAssume = {
      actions = [
        "sts:AssumeRole",
        "sts:TagSession",
      ]
      principals = [{
        type = "Service"
        identifiers = [
          "capabilities.eks.amazonaws.com"
        ]
      }]
    }
  }

  policies = {
    AWSSecretsManagerClientReadOnlyAccess = "arn:aws:iam::aws:policy/AWSSecretsManagerClientReadOnlyAccess"
  }

  tags = local.default_tags
}
