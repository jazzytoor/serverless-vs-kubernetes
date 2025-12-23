## Usage

### Local
- Build and push the docker image by the following commands
  
  ```bash
    # Build image
    docker build -f kubernetes/docker/Dockerfile -t dualstack .
    
    # Tag
    docker tag dualstack:latest xxx.dkr.ecr.xxx.amazonaws.com/dualstack:latest

    # AWS ECR login
    aws ecr get-login-password --region xxx | docker login --username AWS --password-stdin xxx.dkr.ecr.xxx.amazonaws.com

    # Push
    docker push xxx.dkr.ecr.xxx.amazonaws.com/dualstack:latest
  ```

- Docker desktop requires AWS ECR access in order to pull down the image, this can be done by `kubectl create secret docker-registry myawscred -n xxx --docker-server=xxx.dkr.ecr.xxx.amazonaws.com --docker-username=AWS --docker-password="$(aws ecr get-login-password --region xxx)"`.

- Can run the following command to create the Argocd application `kubectl apply -f kubernetes/argocd/app.yaml`.

- To deploy Argo CD locally you can run the following command `kubectl delete -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml`