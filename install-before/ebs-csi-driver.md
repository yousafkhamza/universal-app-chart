# AWS EBS CSI Driver

Required for:

```yaml
persistence:
  storageClassName: gp3
```

---

## Install Addon

```bash
aws eks create-addon \
--cluster-name CLUSTER_NAME \
--addon-name aws-ebs-csi-driver
```

---

## Verify

```bash
kubectl get pods -n kube-system | grep ebs
```

---

## Apply StorageClass

```bash
kubectl apply -f storageclasses/gp3-sc.yaml
```

---

## Verify

```bash
kubectl get storageclass
```