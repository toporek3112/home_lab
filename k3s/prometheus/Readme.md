# Prometheus

Deployed using Helm chart: [prometheus-community/kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) 

| Helm Version | App version |
| ------------ | ----------- |
| 61.2.0       | v0.75.0     |


Install
```
helm isntall --namespace monitoring kube-prometheus prometheus-community/kube-prometheus-stack --version v61.2.0 -f values.yaml 
```

Upgrade
```
helm upgrade --namespace monitoring kube-prometheus prometheus-community/kube-prometheus-stack --version v61.2.0 -f values.yaml 
```
