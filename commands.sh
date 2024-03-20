# run troubleshoot container
docker run -it --rm --network host debug-tools

# get containers IP
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' grafana

# create network cutom_bridge
docker network create --driver bridge --subnet 172.20.0.0/16 custom_bridge

## build image
# prometheus
docker build -t local/prometheus:1.0 prometheus/.
# jmx-exporter
docker build -t local/jmx-exporter:1.11 jmx-exporter/.

# troubleshooting container
docker build -t debug-tools .
docker run -it --rm --network custom_bridge debug-tools

# enter docker container
docker run --rm -it -v ./jmx-exporter:/config local/jmx-exporter:1.8 /bin/sh
docker run --rm -it --entrypoint /bin/sh prom/prometheus:latest -c whoami

# remove all not running containers
docker rm $(docker ps -a -q -f "status=exited")

# permissions
chown toporek3112:docker_container prometheus/ && chmod -R 764 prometheus/

# make root filesystem moutyble --> node_exporter
sudo mount --make-shared /
sudo systemctl restart docker
sudo service docker restart

# create symboliclinks in app folder for frontend and backend
ln -s ../../lan_dashboard/build lan_dashboard_build
ln -s ../../lan_dashboard/backend/ lan_dashboard_backend

# envs
export HOST_IP=$(hostname -I | cut -d' ' -f1)
export REACT_APP_BACKEND_URL=http://${HOST_IP}:3002

# grep
docker logs opentelemetry_collector_export 2>&1 | grep -i error
docker logs opentelemetry_collector_export > delete_me.log 2>&1
