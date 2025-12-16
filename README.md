<h1 align="center">Welcome to serverless-vs-kubernetes 👋</h1>

## ✨ Overview

**serverless-vs-kubernetes** is a comparative project demonstrating how the *same application* behaves when deployed on:
- Serverless (AWS Lambda + API Gateway)
- Kubernetes (EKS)

The app exposes simple demo endpoints — `/`, `/time`, `/visits`, and `/home/{name}` — and showcases the differences in:

- Architecture
- Deployment workflows
- Scalability behaviour
- Operational overhead
- Cost model
- State handling
- Cold starts vs pod lifecycles

This project demonstrates practical cloud engineering and SRE thinking across both deployment models.

## ✨ Features

### Serverless Stack
- AWS Lambda (FastAPI)
- Amazon API Gateway (HTTP API)
- DynamoDB (optional counter state)
- S3 + CloudFront static demo website
- IAM least-privilege
- Fully deployed with Terraform

### Kubernetes Stack
- FastAPI Docker container
- Helm chart for deployment + service
- NGINX Ingress Controller
- Deployment + Service + HPA
- Cluster autoscaling ready
- Optional Kustomize overlays
- GitOps friendly (ArgoCD)

### 🛠️ Shared Application
- `/` – Hello World
- `/time` – Returns UTC time
- `/visits` – Simple per-instance counter
- `/home/{name}` – Personalised greeting

The *exact same code* is deployed using two different architectures.

### 🌐 Static Frontend
- UI to call both APIs
- Hosted on S3 or inside Kubernetes
- Demonstrates latency & behaviour differences

## Author

👤 **Jazz**
