# Terraform AWS EC2 Instance Management

This repository contains Terraform configurations to manage AWS EC2 instances.

## Overview

This guide explains the Terraform commands used for refreshing, applying, replacing AWS EC2 instances, and importing existing instances into the Terraform state.

## Terraform Commands

### 1. Refresh Terraform State

To refresh the Terraform state, ensuring it reflects the current state of the infrastructure, use the following command:

```bash
terraform plan --refresh-only
```

This command ensures that Terraform uses the latest state and configuration when applying changes to your infrastructure.

```bash
terraform apply --refresh-only
```

This command will create a new plan that replaces the specified EC2 instance (aws_instance.example) and output it to a file named example

```bash
terraform plan -replace="aws_instance.example" -out example
```

To apply the replacement plan, run:

```bash
terraform apply example
```

This removes example instace from state file

```bash
tf state rm aws_instance.example
```

This command imports the specified EC2 instance (i-0bf8ef93eaaf65e9a) into the Terraform state, associating it with the aws_instance.example resource.

```bash
terraform import aws_instance.example i-0bf8ef93eaaf65e9a
```

I created EC2 with terraform then I added tags from AWS UI. If I do terraform plan --refresh-only
it shows what extra changes have been done by comparing current configuration with AWS configuration. terraform apply --refresh-only gets the new tags to tfstate file
