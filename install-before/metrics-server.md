# Metrics Server

Required for HPA.

---

## Install

```bash
helm repo add metrics-server \
https://kubernetes-sigs.github.io/metrics-server

helm repo update
```

```bash
helm install metrics-server \
metrics-server/metrics-server \
-n kube-system
```

---

## Verify

```bash
kubectl top nodes
```

```bash
kubectl top pods -A
```