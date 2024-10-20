variable "namespace" {
  type = string
}

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = var.namespace
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "5.30.1" # Adjust to the latest version
  values     = [file("${path.module}/values.yaml")]

  create_namespace = true
}

output "argocd_metadata" {
  value = helm_release.argocd.metadata
}
