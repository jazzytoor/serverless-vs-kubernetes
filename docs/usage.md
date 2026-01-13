# Usage

This document walks you through deploying the **kubernetes** or **serverless** architecture using Terraform.

## Prerequisites

1. **AWS Accounts**
   - Create one AWS account and ensure you have IAM access with sufficient permissions.

2. **Tools**
   - [AWS CLI](https://aws.amazon.com/cli/) installed and configured
   - [Terraform](https://www.terraform.io/downloads) installed

## Configuration

1. Copy the template variables file:

    ```bash
    # kubernetes
    cp kubernetes/terraform/variables.auto.tfvars.tmpl kubernetes/terraform/variables.auto.tfvars

    # serverless
    cp serverless/terraform/variables.auto.tfvars.tmpl serverless/terraform/variables.auto.tfvars
    ```

2. Update the variables in variables.auto.tfvars:

    | Variable           | Description                                                  | Type   |
    | ------------------ | ------------------------------------------------------------ | ------ |
    | `domain`           | Route53 hosted zone                                          | String |
    | `region`           | AWS region (e.g., `eu-west-2`)                               | String |
    | `service`          | Service name / project identifier                            | String |

## Deployment

1. Navigate into the stack you wish to deploy `cd serverless/terraform` or `cd kubernetes/terraform`

2. Initialize Terraform

    `terraform init`

3. Preview the changes

    `terraform plan`

4. Apply the infrastructure

    `terraform apply -auto-approve`

5. You may need to update the `docker` provider to include `host` to ensure its going to the correct Docker daemon address.

## Verification
- Confirm that the VPC and subnets exist in the account
- Confirm either the kubernetes or serverless resources has been created

## Notes / Tips
1. You can destroy everything by running:

    `terraform destroy -auto-approve`
