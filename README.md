# Cats

# CI/CD Pipeline with Verified Blue-Green Deployment  
Automated zero-downtime deployments using GitHub Actions, Minikube, and Kubernetes.  

## Features  
- 🚀 **Automated version tagging** (semantic versioning)  
- 🔄 **Blue-green deployment** with traffic switching  
- 🛡️ **Rollback on failure**  
- 📊 **Prometheus monitoring** integration  
- 🐳 **Docker image versioning**  

## How It Works  
1. **On `master` push**, the pipeline:  
   - Tags the commit with a new major version (`vX.0.0`).  
   - Builds and pushes a Docker image.  
   - Deploys to Minikube in the idle (blue/green) environment.  
   - Validates the deployment before switching traffic.  

2. **If validation fails**:  
   - Rolls back to the last stable version.  

## Prerequisites  
- GitHub Secrets:  
  - `DOCKER_USERNAME` / `DOCKER_PASSWORD`  
  - `GH_PAT` (GitHub Personal Access Token)  
- Kubernetes manifests in the repo (e.g., `sinatra-blue.yaml`, `prometheus-configmap.yaml`).  

## Usage  
1. Clone this repo.  
2. Configure secrets in GitHub.  
3. Push to `master` to trigger the pipeline.  

## Pipeline Steps  
![Pipeline Diagram](https://example.com/pipeline-diagram.png)  
*(Visualize the workflow with a diagram if available.)*  

## Contributing  
PRs welcome! Ensure all changes maintain backward compatibility.  