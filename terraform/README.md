# Getting the infrastructure ready
The base infrastructe (for now only ArgoCD) is deployed using terraform.

## Deploy
```bash
docker run -it --rm --network host -v $(pwd):/app -w /app hashicorp/terraform:latest
```
