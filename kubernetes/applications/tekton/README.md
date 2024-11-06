# Tekton 
CI/CD

## Installation

1. Add repo:
   ```
   helm repo add eddycharly https://eddycharly.github.io/tekton-helm
   ```

2. Install Tekton pipelines:
   ``` 
   helm install -n tekton-pipelines tekton-dashboard eddycharly/dashboard  
   ```

3. (Optionaly) Install Tekton dashboard
   ```
   kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/release-full.yaml
   ```

4. If dasboard install, create ingressRoute:
   ```
   kubectl apply -f ingressRoute
   ``` 