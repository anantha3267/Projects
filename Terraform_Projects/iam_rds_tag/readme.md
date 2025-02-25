# IAM Policy: Access RDS Resources Based on Principal Tag and `rds:db-tag`

This IAM policy grants permissions for the following actions on RDS resources, based on tags and principal tags:

- **Describe** operations for DB instances, DB clusters, and global DB clusters.
- **Reboot**, **start**, and **stop** DB instances.
- Tag-based access control using AWS Principals and RDS resource tags (`rds:db-tag`).

## Policy Overview

The policy allows actions on RDS instances and clusters based on the following criteria:

- **Principal Tag**: The IAM principal (user or role) must have a specific tag (`aws:PrincipalTag/YourPrincipalTagKey`).
- **RDS Resource Tag**: The RDS resource must have the tag `rds:db-tag` with a specific value (`YourTagValue`).

It includes permissions for the following operations:

1. **Describe DB Instances, Clusters, and Global Clusters**: Allows describing RDS resources.
2. **Reboot, Start, and Stop DB Instances**: Grants permission to manage DB instances based on the specified tags.
3. **Add and Remove Tags**: Allows adding or removing tags from RDS resources based on tags associated with the principal.
4. **Tag Resources**: Grants permission to apply the `rds:db-tag` on resources.

## IAM Policy JSON

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "rds:DescribeDBInstances",
        "rds:DescribeDBClusters",
        "rds:DescribeGlobalClusters"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "rds:RebootDBInstance",
        "rds:StartDBInstance",
        "rds:StopDBInstance"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "aws:PrincipalTag/YourPrincipalTagKey": "DBAdmins",
          "rds:db-tag/Environment": "Production"
        }
      }
    }
  ]
}
```
