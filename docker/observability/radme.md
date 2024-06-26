# Observability
This folder holds a docker-compose file which spins up multiple containers which provide a good base to start setting up some monitoring. 

## Containers
+ Grafana
+ Prometheus
+ Node-Exporter
  + Note: This container requires you to run `sudo mount --make-shared /` on you host linux machine so the node-exporter can get the metrics.

