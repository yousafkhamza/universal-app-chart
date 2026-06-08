# AWS EFS CSI Driver

Required for:

```yaml
persistence:
  storageClassName: efs-sc
```

---

## Create EFS

```bash
aws efs create-file-system
```

Save:

```text
fs-xxxxxxxxxxxxx
```

---

## Install Addon

```bash
aws eks create-addon \
--cluster-name CLUSTER_NAME \
--addon-name aws-efs-csi-driver
```

---

## Verify

```bash
kubectl get pods -n kube-system | grep efs
```

---

## Apply StorageClass

Update:

storageclasses/efs-sc.yaml

Replace:

```yaml
fileSystemId: fs-xxxxxxxxxxxxx
```

with your EFS ID.

Apply:

```bash
kubectl apply -f storageclasses/efs-sc.yaml
```