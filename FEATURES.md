# Features

This document describes all supported features available in the Universal App Helm Chart.

---

# Controller Types

The chart supports multiple workload types.

## Deployment

Suitable for:

* APIs
* Web Applications
* Microservices
* Backend Services

Example:

```yaml
controller:
  type: Deployment
```

---

## StatefulSet

Suitable for:

* Redis
* Elasticsearch
* Kafka
* Databases
* Stateful Applications

Example:

```yaml
controller:
  type: StatefulSet
```

---

# Service

Supports Kubernetes Services.

Example:

```yaml
service:
  enabled: true
  type: ClusterIP
  port: 8080
  targetPort: 8080
```

Supported Types:

* ClusterIP
* NodePort
* LoadBalancer

---

# Ingress

Supports Kubernetes Ingress resources.

Example:

```yaml
ingress:
  enabled: true
  className: alb

  hosts:
    - host: api.example.com

      paths:
        - path: /
          pathType: Prefix
```

---

# AWS Load Balancer Controller (ALB)

Supports AWS Application Load Balancer.

Example:

```yaml
ingress:
  enabled: true

  className: alb

  annotations:
    alb.ingress.kubernetes.io/scheme: internal
    alb.ingress.kubernetes.io/target-type: ip

  hosts:
    - host: api.example.com

      paths:
        - path: /
          pathType: Prefix
```

Common Annotations:

* SSL Redirect
* ACM Certificates
* Internal ALB
* Internet Facing ALB
* ALB Groups
* Health Checks

See:

```text
install-before/aws-load-balancer-controller.md
```

---

# Horizontal Pod Autoscaler (HPA)

Supports Kubernetes HPA.

Example:

```yaml
autoscaling:
  enabled: true

  minReplicas: 2
  maxReplicas: 10

  targetCPUUtilizationPercentage: 70
  targetMemoryUtilizationPercentage: 80
```

Requirements:

* Metrics Server

See:

```text
install-before/metrics-server.md
```

---

# Service Account

Supports custom Service Accounts.

Example:

```yaml
serviceAccount:
  create: true

  name: app-sa
```

---

# IRSA

Supports AWS IAM Roles for Service Accounts.

Example:

```yaml
serviceAccount:
  create: true

  name: app-sa

  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::123456789012:role/app-role
```

See:

```text
install-before/irsa.md
```

---

# Environment Variables

Supports direct environment variables.

Example:

```yaml
env:
  - name: APP_ENV
    value: production

  - name: TZ
    value: UTC
```

---

# ConfigMap

Supports automatic ConfigMap creation.

Example:

```yaml
configMap:
  enabled: true

  data:
    APP_ENV: production
    LOG_LEVEL: INFO
```

Generated Resource:

```text
<application-name>-config
```

---

# Secret

Supports automatic Secret creation.

Example:

```yaml
secret:
  enabled: true

  data:
    DB_USER: admin
    DB_PASSWORD: password
```

Generated Resource:

```text
<application-name>-secret
```

---

# envFrom

Supports loading ConfigMap and Secret values directly into containers.

Example:

```yaml
envFrom:
  configMapRef: my-config
  secretRef: my-secret
```

Or use generated resources:

```yaml
envFrom:
  configMapRef: payment-api-config
  secretRef: payment-api-secret
```

---

# Resources

Supports CPU and Memory requests/limits.

Example:

```yaml
resources:
  requests:
    cpu: 250m
    memory: 256Mi

  limits:
    cpu: 1000m
    memory: 1Gi
```

---

# Health Probes

Supports:

* Startup Probe
* Liveness Probe
* Readiness Probe

Example:

```yaml
probes:
  enabled: true

  startup:
    path: /health

  liveness:
    path: /health

  readiness:
    path: /health
```

---

# Persistent Storage

Supports both EBS and EFS storage.

---

## EBS Storage

Suitable for:

* Databases
* Redis
* Elasticsearch
* Single Writer Applications

Example:

```yaml
persistence:
  enabled: true

  storageClassName: gp3

  accessMode: ReadWriteOnce

  size: 20Gi

  mountPath: /data
```

Requirements:

```text
install-before/ebs-csi-driver.md
```

StorageClass:

```text
install-before/storageclasses/gp3-sc.yaml
```

---

## EFS Storage

Suitable for:

* Shared Storage
* Multiple Pods
* File Uploads
* Content Repositories

Example:

```yaml
persistence:
  enabled: true

  storageClassName: efs-sc

  accessMode: ReadWriteMany

  size: 20Gi

  mountPath: /shared
```

Requirements:

```text
install-before/efs-csi-driver.md
```

StorageClass:

```text
install-before/storageclasses/efs-sc.yaml
```

---

# Image Pull Secrets

Supports private container registries.

Example:

```yaml
imagePullSecrets:
  - name: regcred
```

Supported Registries:

* AWS ECR
* Docker Hub
* GitHub Container Registry
* Harbor
* JFrog Artifactory

---

# Node Selector

Supports scheduling workloads to specific nodes.

Example:

```yaml
nodeSelector:
  kubernetes.io/os: linux
```

---

# Tolerations

Supports Kubernetes Taints and Tolerations.

Example:

```yaml
tolerations:
  - key: workload

    operator: Equal

    value: application

    effect: NoSchedule
```

---

# Affinity

Supports Kubernetes Affinity Rules.

Example:

```yaml
affinity:
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
```

---

# Example Configurations

Available under:

```text
examples/
```

Included Examples:

* basic-app.yaml
* full-app.yaml
* complete-utilized.yaml
* alb-ingress.yaml
* efs-storage.yaml
* ebs-gp3-storage.yaml
* hpa.yaml
* irsa.yaml
* configmap.yaml
* secret.yaml
* envfrom.yaml
* statefulset.yaml

---

# AWS EKS Prerequisites

Refer to:

```text
install-before/
```

Documentation Included:

* AWS Load Balancer Controller
* AWS EBS CSI Driver
* AWS EFS CSI Driver
* Metrics Server
* IRSA Setup
* StorageClass Examples

---

# Supported Platforms

Tested on:

* Amazon EKS

Kubernetes Versions:

* 1.29+
* 1.30+
* 1.31+
* 1.32+

---

# Version

Current Release:

```text
v1.0.0
```
