provider "kubernetes" {
  config_path = "./config/kubeconfig"
}

provider "helm" {
  kubernetes {
    config_path = "./config/kubeconfig"
  }
}

locals  {
  namespace_argocd = "argocd"
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = local.namespace_argocd
  }
}

module "argocd" {
  source = "./modules/argocd"
  namespace = local.namespace_argocd
}