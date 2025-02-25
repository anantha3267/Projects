## Account 1

- Username : John has permission to assume role for all resources

## Policy Code

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1738942909094",
      "Action": "sts:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
```

## Account 2

- Create cross-account-role which has fulls3access and trust telationships for account 1 as below

````json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::713881786085:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "originhubs"
        }
      }
    }
  ]
}

```bash
aws sts assume-role `
    --profile john `
    --role-arn "arn:aws:iam::398159724134:role/cross-account-role" `
    --role-session-name JohnSession `
    --external-id "originhubs"
````

```powershell
$env:AWS_ACCESS_KEY_ID="aa"
$env:AWS_SECRET_ACCESS_KEY="aa"
$env:AWS_SESSION_TOKEN="aa"
```

- If an EC2 Instance has to access account 2 s3 then attach the policy of assuming role for all resources to EC2 using the role and run above commands of assuming the role

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::713881786085:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "originhubs"
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:ListBucket"],
      "Resource": ["arn:aws:s3:::ohencryption", "arn:aws:s3:::ohencryption/*"]
    },
    {
      "Effect": "Allow",
      "Action": "kms:Decrypt",
      "Resource": "arn:aws:kms:region:398159724134:key/key-id"
    }
  ]
}
```
