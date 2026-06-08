# AWS Load Balancer Controller

Required for:

```yaml
ingress:
  enabled: true
  className: alb
```

---

## Verify OIDC

```bash
aws eks describe-cluster \
--name CLUSTER_NAME \
--query "cluster.identity.oidc.issuer" \
--output text
```

---

## Download IAM Policy

```bash
curl -O \
https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json
```

---

## Create Policy

```bash
aws iam create-policy \
--policy-name AWSLoadBalancerControllerIAMPolicy \
--policy-document file://iam_policy.json
```

---

## Create Service Account

```bash
eksctl create iamserviceaccount \
--cluster CLUSTER_NAME \
--namespace kube-system \
--name aws-load-balancer-controller \
--attach-policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy \
--approve
```

---

## Install

```bash
helm repo add eks https://aws.github.io/eks-charts

helm repo update
```

```bash
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
-n kube-system \
--set clusterName=CLUSTER_NAME \
--set serviceAccount.create=false \
--set serviceAccount.name=aws-load-balancer-controller
```

---

## Verify

```bash
kubectl get deployment -n kube-system aws-load-balancer-controller
```