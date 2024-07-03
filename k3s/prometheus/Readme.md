# Prometheus

Helm chart: prometheus-community/kube-prometheus-stack

Install:
```
helm install prometheus prometheus-community/kube-prometheus-stack -f values.yaml --namespace monitoring
```

Upgrade:
```
helm upgrade prometheus prometheus-community/kube-prometheus-stack -f values.yaml --namespace monitoring
```