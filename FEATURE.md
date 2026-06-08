# Features

This document explains all supported features.

---

# Deployment

Default:

```yaml
controller:
  type: Deployment
```

---

# StatefulSet

```yaml
controller:
  type: StatefulSet
```

---

# ALB Ingress

```yaml
ingress:

  enabled: true

  className: alb

  annotations:

    alb.ingress.kubernetes.io/scheme: internal

    alb.ingress.kubernetes.io/target-type: ip

  hosts:

    - host: api.company.com

      paths:

        - path: /

          pathType: Prefix
```

---

# HPA

```yaml
autoscaling:

  enabled: true

  minReplicas: 2

  maxReplicas: 10

  targetCPUUtilizationPercentage: 70

  targetMemoryUtilizationPercentage: 80
```

---

# EBS Storage

```yaml
persistence:

  enabled: true

  storageClassName: gp3

  accessMode: ReadWriteOnce

  size: 20Gi

  mountPath: /data
```

---

# EFS Storage

```yaml
persistence:

  enabled: true

  storageClassName: efs-sc

  accessMode: ReadWriteMany

  size: 20Gi

  mountPath: /shared
```

---

# ConfigMap

```yaml
configMap:

  enabled: true

  data:

    APP_ENV: production

    LOG_LEVEL: INFO
```

---

# Secret

```yaml
secret:

  enabled: true

  data:

    DB_USER: admin

    DB_PASSWORD: secret
```

---

# envFrom

```yaml
envFrom:

  configMapRef: payment-api-config

  secretRef: payment-api-secret
```

---

# IRSA

```yaml
serviceAccount:

  create: true

  name: app-sa

  annotations:

    eks.amazonaws.com/role-arn: arn:aws:iam::123456789012:role/app-role
```

---

# Service Types

ClusterIP

```yaml
service:
  type: ClusterIP
```

NodePort

```yaml
service:
  type: NodePort
```

LoadBalancer

```yaml
service:
  type: LoadBalancer
```

---

# Ingress TLS

```yaml
ingress:

  tls:

    - hosts:
        - api.company.com

      secretName: api-company-com
```

---