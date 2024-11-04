variable "namespace" {
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
              "name" = "argocd-argocd-local"
              "port" = 80
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
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "5.30.1" # Adjust to the latest version
  values     = [file("${path.module}/values.yaml")]

  create_namespace = true
}

resource "null_resource" "password_argocd" {
  provisioner "local-exec" {
    command = "kubectl -n argocd get secret argocd-secret -o jsonpath=\"{.data['admin\\.password']}\" | base64 --decode > argocd-login.txt"
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
