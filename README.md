# my_docker
Some of my local docker setups

# Prerequisities

+ docker
+ docker-compose

# IP ranges
Observability: 11-30

Databases: 31-50

Apps: 51-70

# Setup

Create network cutom_bridge

```{bash}
docker network create --driver bridge --subnet 172.20.0.0/16 custom_bridge
```