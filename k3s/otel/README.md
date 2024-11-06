# Openeteletry

## Versions Matrix
|         | Helm Chart                                                                        | Opentelemetry Operator | Opentelemetry |
| ------- | --------------------------------------------------------------------------------- | ---------------------- | ------------- |
| Version | [0.69.0](https://github.com/open-telemetry/opentelemetry-helm-charts/tree/opentelemetry-operator-0.69.0/charts/opentelemetry-operator) | 5.12.0-debian-12-r1    | 11.2.0        |

## [Grafana Operator](https://github.com/grafana/grafana-operator)

Make sure the Bitnami repo is present:
```
helm repo add bitnami https://charts.bitnami.com/bitnami
# helm repo update
```

Install:
```bash
helm install grafana-operator \
              bitnami/grafana-operator \
              -f values.yaml \
              --namespace monitoring \
              --version 4.6.1

# vanilla 
# helm install --namespace monitoring grafana-operator oci://ghcr.io/grafana/helm-charts/grafana-operator -f helm.grafana-operator.yaml --version v5.10.0
```

Upgrade:
```bash
helm upgrade grafana-operator \
              bitnami/grafana-operator \
              -f values.yaml \
              --namespace monitoring \
              --version 4.6.1

# vanilla 
# helm upgrade --namespace monitoring grafana-operator oci://ghcr.io/grafana/helm-charts/grafana-operator -f helm.grafana-operator.yaml --version v5.10.0
```



