# Welcome to serverless-vs-kubernetes

## Overview

**serverless-vs-kubernetes** is a comparative project demonstrating how the *same application* behaves when deployed on:
- Serverless (AWS Lambda + API Gateway)
- Kubernetes (EKS)

The app exposes simple demo endpoints — `/`, `/time`, `/visits`, and `/home/{name}`.

## Architecture

![architecture diagram](/docs/architecture-diagram.png)

## Features

### Serverless Stack
- AWS Lambda (FastAPI)
- Amazon API Gateway
- DynamoDB
- S3 + CloudFront static demo website
- Fully deployed with Terraform

### Kubernetes Stack
- FastAPI Docker container
- Deployment + Service
- AWS Load Balancer Controller
- ArgoCD
- Fully deployed with Terraform

### Shared Application
- `/` – Hello World
- `/time` – Returns UTC time
- `/visits` – Simple per-instance counter
- `/home/{name}` – Personalised greeting

The *exact same code* is deployed using two different architectures.

## Author

👤 **Jazz**
