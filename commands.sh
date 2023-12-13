# get containers up
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' grafana


