# get containers up
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' grafana

# create network cutom_bridge
docker network create --driver bridge --subnet 172.20.0.0/16 custom_bridge

