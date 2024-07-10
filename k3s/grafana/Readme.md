# Grafana

## Grafana Operator

Helm chart: open-telemetry/opentelemetry-collector

Install:
```
helm install --namespace monitoring grafana-operator oci://ghcr.io/grafana/helm-charts/grafana-operator -f helm.grafana-operator.yaml --version v5.10.0
```

Upgrade:
```
helm upgrade --namespace monitoring grafana-operator oci://ghcr.io/grafana/helm-charts/grafana-operator -f helm.grafana-operator.yaml --version v5.10.0
```

## Grafana

Deploy Grafana instance

```
kubectl apply -f grafana
```


