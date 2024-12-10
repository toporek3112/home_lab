terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.33.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.5"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.16.1"
    }
    keepass = {
      source  = "iSchluff/keepass"
      version = "1.0.1"
    }
  }
}

##################################################
################# SECRETS STORE ##################
##################################################

variable "KeyPass_Database" {
  type      = string
  sensitive = true
}
variable "KeyPass_Password" {
  type      = string
  sensitive = true
}

provider "keepass" {
  database = var.KeyPass_Database
  password = var.KeyPass_Password
}

module "secrets" {
  source           = "./modules/secrets"
}

##################################################
############ K8S WORKLOADS MANAGEMENT ############
##################################################

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

# Fetch the manifest content from the specified URL
data "http" "prometheus_servicemonitor_crd" {
  url = "https://raw.githubusercontent.com/prometheus-community/helm-charts/refs/tags/kube-prometheus-stack-66.1.1/charts/kube-prometheus-stack/charts/crds/crds/crd-servicemonitors.yaml"
}
# Apply the manifest in the Kubernetes cluster
resource "kubernetes_manifest" "prometheus_servicemonitor_crd" {
  manifest = yamldecode(data.http.prometheus_servicemonitor_crd.response_body)
}

resource "kubernetes_namespace" "crossplane" {
  metadata {
    name = "crossplane-system"
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

module "crossplane" {
  depends_on = [ kubernetes_namespace.crossplane, kubernetes_manifest.prometheus_servicemonitor_crd ]
  source           = "./modules/crossplane"
  namespace        = kubernetes_namespace.crossplane.id
  chart            = "crossplane"
  chart_version    = "1.18.1"
  chart_repository = "https://charts.crossplane.io/stable"
  image_repository = "xpkg.upbound.io/crossplane/crossplane"
  image_tag        = ""
}

# https://github.com/bitnami/charts/tree/argo-cd/7.0.20/bitnami/argo-cd
# https://github.com/argoproj/argo-helm/tree/argo-cd-7.7.0/charts/argo-cd
module "argocd" {
  depends_on = [ kubernetes_namespace.argocd, kubernetes_manifest.prometheus_servicemonitor_crd ]
  source           = "./modules/argocd"
  namespace        = kubernetes_namespace.argocd.id
  chart            = "argo-cd"
  chart_version    = "7.7.0"
  chart_repository = "https://argoproj.github.io/argo-helm"
  image_repository = "311200/argocd"
  image_tag        = "0.0.9-arm64-2.13.0"
}

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
