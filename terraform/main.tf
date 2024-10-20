provider "kubernetes" {
  config_path = "./config/k3s"
}

provider "helm" {
  kubernetes {
    config_path = "./config/k3s"
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

resource "kubernetes_manifest" "argocd_ingressroute" {
  manifest = {
    "apiVersion" = "traefik.containo.us/v1alpha1"
    "kind"       = "IngressRoute"
    "metadata" = {
      "name"      = "argocd-ingress"
      "namespace" = kubernetes_namespace.argocd.metadata[0].name
    }
    "spec" = {
      "entryPoints" = [
        "web"
      ]
      "routes" = [
        {
          "match" = "Host(`argocd.local`)"
          "kind"  = "Rule"
          "services" = [
            {
              "name" = "argocd-server"
              "port" = 80
            }
          ]
        }
      ]
    }
  }
}

module "argocd" {
  source = "./modules/argocd"
  namespace = local.namespace_argocd
}