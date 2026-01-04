## Usage
1. Update yaml files by replacing <AWS_ACCOUNT_ID> with your AWS Account ID.
2. Copy the template variables file:

    ```bash
    cp kubernetes/terraform/variables.auto.tfvars.tmpl kubernetes/terraform/variables.auto.tfvars
    ```
3. Update the variables in variables.auto.tfvars:

    | Variable  | Description                       | Type   |
    | --------- | --------------------------------- | ------ |
    | `region`  | AWS region (e.g., `eu-west-2`)    | String |
    | `service` | Service name / project identifier | String |
    | `host`    | Docker daemon address             | String |
4. Run the following Terraform commands to deploy infrastructure

    ```bash
    cd kubernetes/terraform

    terraform init
    terraform plan
    terraform apply -auto-approve
    ```
5. Once Argocd is deployed to the EKS via the Helm chart we need to get the password and port forward the server in order to access the console.

    ```bash
    # Get password for admin user account
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

    # Update kubectl config
    aws eks update-kubeconfig --region eu-west-2 --name my-cluster

    # Port forward the argocd server
    kubectl port-forward svc/argocd-server -n argocd 8080:443

    # Access the console via https://localhost:8080
    ```

- Run the following commands in order to deploy the applications to Argocd.

  ```bash
  kubectl apply -f kubernetes/argocd/frontend.yaml
  kubectl apply -f kubernetes/argocd/backend.yaml
  ```

### Locally

1. Docker desktop requires AWS ECR access in order to pull down the image, this can be done by `kubectl create secret docker-registry myawscred -n xxx --docker-server=xxx.dkr.ecr.xxx.amazonaws.com --docker-username=AWS --docker-password="$(aws ecr get-login-password --region xxx)"`.

2. In order to use Argo CD locally you can run the following steps
  1. Ensure Docker Desktop is running with Kubernetes enabled.
  2. `kubectl create namespace argocd`.
  3. Deploy Argo CD locally you can run the following command `kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml`.
  4. Configure port forwarding for dashboard access `kubectl port-forward svc/argocd-server -n argocd 8080:443`.
  5. Username to be `admin` and password you can get by running the following command `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo`
  6. Now you can access by `https://localhost:8080/`

3. Can run the following command to create the Argocd application `kubectl apply -f kubernetes/argocd/frontend.yaml`.
