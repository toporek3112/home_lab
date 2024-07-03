# Grafana

## Grafana Operator

Helm chart: open-telemetry/opentelemetry-collector

Install/Upgrade:
```
helm upgrade -i grafana-operator oci://ghcr.io/grafana/helm-charts/grafana-operator -f helm.grafana-operator.yaml --version v5.9.2
```

## Grafana

Deploy Grafana instance

```
kubectl apply -f grafana
```


