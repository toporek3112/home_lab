# get containers up
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' grafana

# create network cutom_bridge
docker network create --driver bridge --subnet 172.20.0.0/16 custom_bridge

# build image
# troubleshooting container
docker build -t debug-tools .
docker run -it --rm --network custom_bridge debug-tools

# prometheus
docker build -t local/prometheus:1.0 prometheus/.
# jmx-exporter
docker build -t local/jmx-exporter:1.11 jmx-exporter/.


# enter docker container
docker run --rm -it -v ./jmx-exporter:/config local/jmx-exporter:1.8 /bin/sh
docker run --rm -it --entrypoint /bin/sh prom/prometheus:latest -c whoami

# remove all not running containers
docker rm $(docker ps -a -q -f "status=exited")

# permissions
chown toporek3112:docker_container prometheus/ && chmod -R 764 prometheus/

