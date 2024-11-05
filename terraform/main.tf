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
module "argocd" {
  source = "./modules/argocd"
  namespace = kubernetes_namespace.argocd.id
  chart = "argo-cd"
  chart_version = "7.0.20"
  repository = "https://charts.bitnami.com/bitnami"
}
