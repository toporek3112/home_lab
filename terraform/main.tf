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

module "argocd" {
  source = "./modules/argocd"
  namespace = kubernetes_namespace.argocd.id
}