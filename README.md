# Universal App Helm Chart

A reusable Helm chart for deploying applications on AWS EKS.

This chart provides a standardized way to deploy containerized workloads while supporting common Kubernetes and AWS EKS features such as:

* Deployment
* StatefulSet
* Service
* ALB Ingress
* Horizontal Pod Autoscaler (HPA)
* ConfigMap
* Secret
* envFrom
* EBS Storage
* EFS Storage
* IRSA (IAM Roles for Service Accounts)
* ServiceAccount
* NodeSelector
* Tolerations
* Affinity

---

## Repository Structure

```text
universal-app-chart/
│
├── Chart.yaml
├── values.yaml
├── README.md
├── FEATURES.md
├── CHANGELOG.md
├── LICENSE
│
├── templates/
│   ├── _helpers.tpl
│   ├── deployment.yaml
│   ├── statefulset.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── hpa.yaml
│   ├── pvc.yaml
│   ├── configmap.yaml
│   ├── secret.yaml
│   └── serviceaccount.yaml
│
├── examples/
│   ├── basic-app.yaml
│   ├── full-app.yaml
│   ├── complete-utilized.yaml
│   ├── alb-ingress.yaml
│   ├── efs-storage.yaml
│   ├── ebs-gp3-storage.yaml
│   ├── hpa.yaml
│   ├── irsa.yaml
│   ├── configmap.yaml
│   ├── secret.yaml
│   ├── envfrom.yaml
│   └── statefulset.yaml
│
└── install-before/
    ├── README.md
    ├── aws-load-balancer-controller.md
    ├── ebs-csi-driver.md
    ├── efs-csi-driver.md
    ├── metrics-server.md
    ├── irsa.md
    │
    ├── storageclasses/
    │   ├── gp3-sc.yaml
    │   └── efs-sc.yaml
    │
    └── examples/
        ├── alb-values.yaml
        ├── ebs-values.yaml
        ├── efs-values.yaml
        ├── hpa-values.yaml
        └── irsa-values.yaml
```

---

## Prerequisites

For AWS EKS environments, the following components are recommended:

### Required

* AWS Load Balancer Controller
* AWS EBS CSI Driver
* Metrics Server

### Optional

* AWS EFS CSI Driver
* IRSA (IAM Roles for Service Accounts)

Refer to the `install-before/` directory for setup instructions.

---

## Add Helm Repository

```bash
helm repo add universal-app \
https://yousafkhamza.github.io/universal-app-chart

helm repo update
```

Verify:

```bash
helm search repo universal-app
```

---

## Quick Start

Deploy using default values:

```bash
helm install my-app \
universal-app/universal-app
```

Deploy to a specific namespace:

```bash
helm install my-app \
universal-app/universal-app \
-n test \
--create-namespace
```

---

## Deploy Using Custom Values

```bash
helm install payment-api \
universal-app/universal-app \
-f values.yaml
```

Upgrade:

```bash
helm upgrade payment-api \
universal-app/universal-app \
-f values.yaml
```

Uninstall:

```bash
helm uninstall payment-api
```

---

## Example Configurations

### Basic Application

```bash
helm install app \
universal-app/universal-app \
-f examples/basic-app.yaml
```

### ALB Ingress

```bash
helm install app \
universal-app/universal-app \
-f examples/alb-ingress.yaml
```

### EFS Storage

```bash
helm install app \
universal-app/universal-app \
-f examples/efs-storage.yaml
```

### EBS Storage

```bash
helm install app \
universal-app/universal-app \
-f examples/ebs-gp3-storage.yaml
```

### Horizontal Pod Autoscaler

```bash
helm install app \
universal-app/universal-app \
-f examples/hpa.yaml
```

### IRSA

```bash
helm install app \
universal-app/universal-app \
-f examples/irsa.yaml
```

### StatefulSet

```bash
helm install redis \
universal-app/universal-app \
-f examples/statefulset.yaml
```

### Complete Feature Example

```bash
helm install app \
universal-app/universal-app \
-f examples/complete-utilized.yaml
```

---

## Features

The chart supports:

| Feature        | Supported |
| -------------- | --------- |
| Deployment     | Yes       |
| StatefulSet    | Yes       |
| Service        | Yes       |
| ALB Ingress    | Yes       |
| HPA            | Yes       |
| ConfigMap      | Yes       |
| Secret         | Yes       |
| envFrom        | Yes       |
| EBS Storage    | Yes       |
| EFS Storage    | Yes       |
| IRSA           | Yes       |
| ServiceAccount | Yes       |
| NodeSelector   | Yes       |
| Tolerations    | Yes       |
| Affinity       | Yes       |

For detailed examples and configuration options, see `FEATURES.md`.

---

## AWS EKS Documentation

Additional setup guides are available in:

```text
install-before/
```

Including:

* AWS Load Balancer Controller
* AWS EBS CSI Driver
* AWS EFS CSI Driver
* Metrics Server
* IRSA Configuration
* StorageClass Examples

---

## Release Notes

See:

```text
CHANGELOG.md
```

---

## License

MIT License
