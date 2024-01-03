# my_docker
Some of my local docker setups

# Prerequisities

+ docker
+ docker-compose

# Setup

Create network cutom_bridge

```{bash}
docker network create --driver bridge --subnet 172.20.0.0/16 custom_bridge
```