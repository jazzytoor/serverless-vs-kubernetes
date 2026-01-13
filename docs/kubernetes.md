## Kubernetes Manifests & Core Concepts

- **Pod**
  Kubernetes’ smallest deployable unit, comprising one or more containers that share networking, storage, and lifecycle.

- **Deployment**
  Ensures the desired number of Pods are running at all times and provides declarative updates, rollbacks, and scaling via ReplicaSets.

- **ReplicaSet**
  Guarantees a specified number of identical Pod replicas are running, improving availability and resilience.

- **StatefulSet**
  Manages stateful applications by providing stable network identities, persistent storage, and ordered Pod creation and termination.

- **Service**
  Defines a logical grouping of Pods and a stable access point, enabling loose coupling and internal load balancing between microservices.

- **Ingress**
  Manages external HTTP/HTTPS access to Services, providing routing, load balancing, and optional TLS termination.

- **Namespace**
  Provides logical isolation within a cluster, enabling multiple environments or teams to share the same physical resources.

- **ConfigMap**
  Stores non-sensitive configuration data that can be injected into Pods as environment variables or mounted files.

- **Secret**
  Stores sensitive information such as passwords, tokens, or keys, securely mountable into Pods or exposed as environment variables.

- **ServiceAccount**
  Provides an identity for Pods, enabling fine-grained access control to the Kubernetes API via RBAC.

- **Role / RoleBinding**
  Defines and assigns permissions for API operations within a namespace, forming the foundation of Kubernetes RBAC.

- **DaemonSet**
  Ensures a Pod runs on all or selected nodes, commonly used for monitoring, logging, or networking agents.

- **Job**
  Represents a finite, one-off task that runs to completion, ensuring a specified number of Pods successfully terminate.

- **PersistentVolume (PV)**
  Represents a piece of cluster storage provisioned by an administrator or dynamically via a StorageClass.

- **PersistentVolumeClaim (PVC)**
  A request for storage by a Pod, abstracting away the underlying storage implementation.

- **Volume**
  Provides shared or persistent storage to Pods, surviving container restarts within the Pod lifecycle.

- **NetworkPolicy**
  Defines rules that control traffic flow between Pods and namespaces, improving security through network segmentation.

## Commands
- **Update Kubeconfig**
  `aws eks update-kubeconfig --region <your-region> --name <cluster-name>`
