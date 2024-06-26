# raspi_docker
This repository is used to run and test some docker containers setup by using docker-compose files. It consists of a "base" compose file in the root path of this project that spins up a `nginx` container which binds to port `80`. This compose file also creates the custom docker network `raspi_docker_custom_bridge` in which all containers have configured their IP addesses. The nginx is configured to resolve domain names like `grafana.local` and forward the request to the designated containers. This comes very handy when this setup runs on a raspbarry pi and you have configured the host file on you machine or if you have a local DNS server :smile:.  

# ToDo:
- [ ] make sure all containers run as non root
  - [ ] esp_backend 
  - [ ] nginx
  - [ ] lan_dashboard_backend


# Prerequisities

+ docker
+ docker-compose

# Network
Network: `188.20.0.0/16` (I know, way to big --> will probably change)

### IP ranges
| Folder        | from        | to          |
| ------------- | ----------- | ----------- |
| Observability | 188.20.0.11 | 188.20.0.30 |
| Databases     | 188.20.0.31 | 188.20.0.50 |
| Apps          | 188.20.0.51 | 188.20.0.70 |

# Setup
In root path:

```{bash}
docker-compose up -d
```

After that follow the readme in the folders. 
