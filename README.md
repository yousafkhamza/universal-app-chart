# Universal App Helm Chart

Reusable Helm chart for deploying applications on AWS EKS.

## Features

- Deployment
- StatefulSet
- Service
- ALB Ingress
- HPA
- EBS Storage
- EFS Storage
- ConfigMap
- Secret
- envFrom
- IRSA
- ServiceAccount

---

# Prerequisites

See:

install-before/

Required components:

- AWS Load Balancer Controller
- AWS EBS CSI Driver
- Metrics Server

Optional:

- AWS EFS CSI Driver
- IRSA

---

# Install

Clone repository:

```bash
git clone https://github.com/<your-github>/universal-app-chart.git

cd universal-app-chart
```

Lint chart:

```bash
helm lint .
```

Render manifests:

```bash
helm template myapp .
```

Install:

```bash
helm install myapp .
```

Upgrade:

```bash
helm upgrade myapp .
```

Delete:

```bash
helm uninstall myapp
```

---

# Using Custom Values

```bash
helm install myapp . \
-f values.yaml
```

Example:

```bash
helm install payment-api . \
-f examples/full-app.yaml
```

---

# Combine Features

ALB + EFS + HPA:

```bash
helm install payment-api . \
-f examples/alb-ingress.yaml \
-f examples/efs-storage.yaml \
-f examples/hpa.yaml
```

ALB + IRSA + HPA:

```bash
helm install payment-api . \
-f examples/alb-ingress.yaml \
-f examples/irsa.yaml \
-f examples/hpa.yaml
```

---

# Deployment Example

```yaml
image:
  repository: 123456789012.dkr.ecr.ap-south-1.amazonaws.com/payment-api
  tag: "1.0.0"

service:
  port: 8080
  targetPort: 8080
```

Install:

```bash
helm install payment-api . \
-f app-values.yaml
```

---

# StatefulSet Example

```yaml
controller:
  type: StatefulSet
```

Example use cases:

- PostgreSQL
- Redis
- Elasticsearch
- RabbitMQ

---

# Version

Current Version:

v1.0.0