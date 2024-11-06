provider "kubernetes" {
  config_path = "./config/kubeconfig"
}
provider "helm" {
  kubernetes {
    config_path = "./config/kubeconfig"
  }
}

locals {
  git_repo = "https://github.com/toporek3112/home_lab.git"
  git_branch = "main"
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

# https://github.com/bitnami/charts/tree/argo-cd/7.0.20/bitnami/argo-cd
# https://github.com/argoproj/argo-helm/tree/argo-cd-7.7.0/charts/argo-cd
module "argocd" {
  depends_on = [ kubernetes_namespace.argocd ]
  source           = "./modules/argocd"
  namespace        = kubernetes_namespace.argocd.id
  chart            = "argo-cd"
  chart_version    = "7.7.0" # Update this to match the latest version of the native chart
  chart_repository = "https://argoproj.github.io/argo-helm"
  image_repository = "311200/argocd"
  image_tag        = "0.0.6-arm64-2.13.0"
}

##################################################
################ APPLICATIONSETS #################
##################################################
resource "kubernetes_manifest" "applicationset_home_lab" {
  depends_on = [ module.argocd ]
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "ApplicationSet"
    metadata = {
      name      = "home-lab"
      namespace = "argocd"
    }
    spec = {
      goTemplate        = true
      goTemplateOptions = ["missingkey=error"]
      generators = [{
        git = {
          repoURL    = local.git_repo
          revision   = local.git_branch
          directories = [{
            path = "kubernetes/*/*/dev"
          }]
          values = {
            namespace = "{{index .path.segments 1}}"
            app_name  = "{{index .path.segments 2}}"
          }
        }
      }]
      template = {
        metadata = {
          name   = "{{.values.app_name}}"
          labels = {
            staging   = "dev"
            namespace = "{{.values.namespace}}"
            app       = "{{.values.app_name}}"
          }
        }
        spec = {
          project    = "default"
          syncPolicy = {
            syncOptions = ["CreateNamespace=true"]
          }
          source = {
            repoURL        = local.git_repo
            targetRevision = local.git_branch
            path           = "{{.path.path}}"
          }
          destination = {
            server    = "https://kubernetes.default.svc"
            namespace = "{{.values.namespace}}"
          }
        }
      }
    }
  }
}
