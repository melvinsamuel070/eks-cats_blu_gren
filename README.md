# Cats

Amazing Sinatra webapp that returns an URL for a random cat picture on its `/` endpoint.

## Configuration

You may set these variables through the process's ENV:

- `RACK_ENV`: Defaults to `production`.
- `PORT`: Defaults to `8000`.
- `WEB_CONCURRENCY`: Number of processes managed by [Puma](http://puma.io/).
Defaults to `1`.
- `MAX_THREADS`: Number of threads per process. Defaults to `1`.

## Running it

If you're bundling the gems, use `bundle exec puma`; otherwise, `puma` is enough.




# Sinatra Kubernetes Deployment with Autoscaling

A guide to deploying a Sinatra web app on Kubernetes with Horizontal Pod Autoscaling (HPA).

## 📌 Table of Contents
- [Application Overview](#-application-overview)
- [Prerequisites](#-prerequisites)
- [Deployment Steps](#-deployment-steps)
- [Autoscaling Setup](#-autoscaling-setup)
- [Troubleshooting](#-troubleshooting)
- [Key Lessons](#-key-lessons)

---

## 🚀 Application Overview
A Sinatra web service that:
- Serves cat images from an external API
- Runs in a Docker container
- Scales automatically based on CPU usage

---

## 🔧 Prerequisites
1. **Local Environment**:
   - Docker
   - kubectl
   - Minikube (for local testing) or access to a Kubernetes cluster

2. **Kubernetes Cluster**:
   ```bash
   minikube start --cpus=4 --memory=4096
   minikube addons enable metrics-server
🛠 Deployment Steps
1. Build and Push Docker Image
bash
docker build -t melvinsamuel070/sanity:1.0.0 .
docker push melvinsamuel070/sanity:1.0.0
2. Deploy to Kubernetes
bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f hpa.yaml
3. Verify Deployment
bash
kubectl get pods -w
kubectl get svc sinatra-service
📊 Autoscaling Setup
Horizontal Pod Autoscaler (HPA) configuration:

yaml
# hpa.yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: sinatra-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: sinatra-v1
  minReplicas: 2
  maxReplicas: 5
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
To test scaling:

bash
# Generate load
kubectl run -it --rm load-generator \
  --image=busybox \
  -- /bin/sh -c "while true; do wget -qO- http://sinatra-service:80; sleep 0.05; done"

# Monitor scaling
watch -n 2 "kubectl get hpa sinatra-hpa; kubectl get pods"
🐛 Troubleshooting
1. Image Pull Errors
Error: ImagePullBackOff
Fix:

bash
# For private images:
kubectl create secret docker-registry regcred \
  --docker-server=docker.io \
  --docker-username=<your-username> \
  --docker-password=<your-password>
2. Readiness Probe Failing
Error: connection refused on /health
Fix: Add health endpoint in app.rb:

ruby
get '/health' do
  status 200
  'OK'
end
3. HPA Not Scaling
Error: unable to fetch metrics
Fix:

bash
minikube addons enable metrics-server
kubectl -n kube-system edit deployment metrics-server
Add these args:

yaml
args:
  - --kubelet-insecure-tls
  - --kubelet-preferred-address-types=InternalIP
💡 Key Lessons Learned
Always define CPU requests in your deployment for HPA to work

Test readiness probes before deploying

Metrics Server needs special flags in Minikube

Scale-down takes ~5 minutes by default

🚀 Next Steps
Add memory-based autoscaling

Set up Prometheus monitoring

Configure alerts for scaling events


### How to Use This File:
1. Copy the entire content
2. Save as `README.md` in your project root
3. Update the Docker image name and paths as needed

This README provides:
- Clear setup instructions
- Ready-to-use commands
- Structured troubleshooting guide
- Future improvement ideas

Would you like me to add any additional sections (e.g., CI/CD setup, monitoring)?