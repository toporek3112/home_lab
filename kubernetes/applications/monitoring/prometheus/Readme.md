# Prometheus

Deployed using Helm chart: [prometheus-community/kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) 

## Version Matrix
| Helm Version                                                                                                                 | Prometheus Operator | Prometheus |
| ---------------------------------------------------------------------------------------------------------------------------- | ------------------- | ---------- |
| [61.2.0](https://github.com/prometheus-community/helm-charts/blob/kube-prometheus-stack-61.2.0/charts/kube-prometheus-stack) | 0.75.0              | 2.53.0     |


Install
```
helm isntall --namespace monitoring kube-prometheus prometheus-community/kube-prometheus-stack --version v61.2.0 -f values.yaml 
```

Upgrade
```
helm upgrade --namespace monitoring kube-prometheus prometheus-community/kube-prometheus-stack --version v61.2.0 -f values.yaml 
```
