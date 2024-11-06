# Grafana

## Versions Matrix
|         | Helm Chart                                                                             | Grafana Operator    | Grafana |
| ------- | -------------------------------------------------------------------------------------- | ------------------- | ------- |
| Version | [4.6.1](https://github.com/bitnami/charts/tree/grafana-operator/4.6.1/bitnami/grafana) | 5.12.0-debian-12-r1 | 11.2.0  |

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
# helm install --namespace monitoring grafana-operator oci://ghcr.io/grafana/helm-charts/grafana-operator -f grafana-operator.yaml --version v5.14.0
```

Upgrade:
```bash
helm upgrade grafana-operator \
              bitnami/grafana-operator \
              -f values.yaml \
              --namespace monitoring \
              --version 4.6.1

# vanilla 
# helm upgrade --namespace monitoring grafana-operator oci://ghcr.io/grafana/helm-charts/grafana-operator -f grafana-operator.yaml --version v5.14.0
```



