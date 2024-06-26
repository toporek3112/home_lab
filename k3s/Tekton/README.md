# Tekton 
CI/CD

## Installation

helm repo add eddycharly https://eddycharly.github.io/tekton-helm
helm install -n tekton-pipelines tekton-dashboard eddycharly/dashboard  

kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/release-full.yaml