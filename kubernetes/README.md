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

- In order to use Argo CD locally you can run the following steps
  1. Ensure Docker Desktop is running with Kubernetes enabled.
  2. `kubectl create namespace argocd`.
  3. Deploy Argo CD locally you can run the following command `kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml`.
  4. Configure port forwarding for dashboard access `kubectl port-forward svc/argocd-server -n argocd 8080:443`.
  5. Username to be `admin` and password you can get by running the following command `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo`
  6. Now you can access by `https://localhost:8080/`

- Can run the following command to create the Argocd application `kubectl apply -f kubernetes/argocd/frontend.yaml`.