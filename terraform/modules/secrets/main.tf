terraform {
  required_providers {
    keepass = {
      source  = "iSchluff/keepass"
      version = "1.0.1"
    }
  }
}

data "keepass_entry" "objstore_yml" {
  path = "MySecrets/TheLab/K8s/gcp_service_account-local-thanos-bucket-sse-kms"
}

resource "kubernetes_secret" "objstore_yml" {
  metadata {
    name      = "thanos-objstore-config"
    namespace = "monitoring"
  }

  data = {
    "objstore.yml" = data.keepass_entry.objstore_yml.notes
  }
}
