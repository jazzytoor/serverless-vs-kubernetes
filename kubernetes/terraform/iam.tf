data "aws_iam_policy_document" "argocd_image_updater" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "argocd_image_updater" {
  name               = "${module.eks.cluster_name}-argocd-image-updater"
  assume_role_policy = data.aws_iam_policy_document.argocd_image_updater.json
}

resource "aws_iam_role_policy_attachment" "argocd_image_updater" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.argocd_image_updater.name
}

resource "aws_eks_pod_identity_association" "argocd_image_updater" {
  cluster_name    = module.eks.cluster_name
  namespace       = "argocd"
  service_account = "argocd-image-updater"
  role_arn        = aws_iam_role.argocd_image_updater.arn
}
