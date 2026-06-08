# IRSA

IAM Roles for Service Accounts

Used for:

- S3
- DynamoDB
- SQS
- SNS
- Secrets Manager

without AWS keys.

---

## Create IAM Service Account

```bash
eksctl create iamserviceaccount \
--cluster CLUSTER_NAME \
--namespace default \
--name app-sa \
--attach-policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/S3ReadOnly \
--approve
```

---

## Helm Values

```yaml
serviceAccount:

  create: true

  name: app-sa

  annotations:

    eks.amazonaws.com/role-arn: arn:aws:iam::<ACCOUNT_ID>:role/app-sa
```

---

## Verify

```bash
kubectl describe sa app-sa
```