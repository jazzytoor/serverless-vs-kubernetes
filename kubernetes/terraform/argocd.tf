resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "8.5.8"

  values = [file("argocd.yaml")]

  depends_on = [module.eks]
}

resource "helm_release" "updater" {
  name = "updater"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-image-updater"
  namespace        = "argocd"
  create_namespace = true
  version          = "0.12.3"

  values = [file("argocd-image-updater.yaml")]

  depends_on = [helm_release.argocd]
}
