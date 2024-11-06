# Opentelemetry Collector

Helm chart: open-telemetry/opentelemetry-collector

Install:
```
helm install otel-test open-telemetry/opentelemetry-collector -f values.yaml --namespace monitoring
```

Upgrade:
```
helm upgrade otel-test open-telemetry/opentelemetry-collector -f values.yaml --namespace monitoring
```