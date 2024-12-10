variable "namespace" {
  type = string
}
variable "chart" {
  type = string
}
variable "chart_version" {
  type = string
}
variable "chart_repository" {
  type = string
}
variable "image_repository" {
  type = string
}
variable "image_tag" {
  type = string
}

resource "helm_release" "crossplane" {
  name       = "crossplane"
  namespace  = var.namespace
  chart      = var.chart
  version    = var.chart_version
  repository = var.chart_repository
  values = [templatefile("${path.module}/values.yaml", {
    image_repository = var.image_repository,
    image_tag        = var.image_tag,
  })]
}
