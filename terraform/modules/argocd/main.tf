variable "namespace" {
  type = string
}
variable "chart" {
  type = string
}
variable "chart_version" {
  type = string
}
variable "repository" {
  type = string
}

resource "kubernetes_manifest" "argocd_ingressroute" {
  manifest = {
    "apiVersion" = "traefik.containo.us/v1alpha1"
    "kind"       = "IngressRoute"
    "metadata" = {
      "name"      = "argocd-ingress"
      "namespace" = var.namespace
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
              "port" = 443
            }
          ]
        }
      ]
    }
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = var.namespace
  chart      = var.chart
  version    = var.chart_version
  repository = var.repository
  values     = [file("${path.module}/values.yaml")]
}

resource "null_resource" "password_argocd" {
  provisioner "local-exec" {
    command = "kubectl -n argocd get secret argocd-secret -o jsonpath=\"{.data['admin\\.password']}\" | base64 --decode > argocd-login.txt"
  }
}

resource "kubernetes_manifest" "argocd_app" {
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind"       = "Application"
    "metadata" = {
      "name"      = "example-app-kustomize"
      "namespace" = var.namespace
    }
    "spec" = {
      "project" = "default"
      "source" = {
        "repoURL"        = "https://github.com/toporek3112/home_lab.git"
        "targetRevision" = "12-setup-argocd-with-terraform"
        "path"           = "kubernetes/overlays/dev"
        "kustomize" = {
          "namePrefix" = "dev-"
        }
      }
      "destination" = {
        "server"    = "https://kubernetes.default.svc"
        "namespace" = "argocd"
      }
      "syncPolicy" = {
        "automated" = {
          "prune" = true
          "selfHeal" = true
        }
      }
    }
  }
}



# resource "null_resource" "del-argo-pass" {
#   depends_on = [null_resource.password]
#   provisioner "local-exec" {
#     command = "kubectl -n argocd delete secret argocd-secret"
#   }
# }

output "argocd_metadata" {
  value = helm_release.argocd.metadata
}
