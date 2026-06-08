# EKS Prerequisites

Before deploying applications using this chart, ensure the required EKS components are installed.

## Required

- AWS Load Balancer Controller
- AWS EBS CSI Driver
- Metrics Server

## Optional

- AWS EFS CSI Driver
- IRSA

---

# Quick Checklist

| Component | Required |
|------------|------------|
| AWS Load Balancer Controller | Yes |
| AWS EBS CSI Driver | Yes |
| Metrics Server | Yes |
| AWS EFS CSI Driver | Optional |
| IRSA | Optional |

---

# Verification

Check addons:

```bash
kubectl get pods -n kube-system
```

Check storage classes:

```bash
kubectl get storageclass
```

Check metrics:

```bash
kubectl top nodes
```