provider "kubernetes" {
  config_path = "./config/kubeconfig"
}

provider "helm" {
  kubernetes {
    config_path = "./config/kubeconfig"
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

# https://github.com/bitnami/charts/tree/argo-cd/7.0.20/bitnami/argo-cd
# https://github.com/argoproj/argo-helm/tree/argo-cd-7.7.0/charts/argo-cd
module "argocd" {
  source           = "./modules/argocd"
  namespace        = kubernetes_namespace.argocd.id
  chart            = "argo-cd"
  chart_version    = "7.7.0" # Update this to match the latest version of the native chart
  chart_repository = "https://argoproj.github.io/argo-helm"
  image_repository = "311200/argocd"
  image_tag        = "0.0.5-arm64-2.13.0"
}
