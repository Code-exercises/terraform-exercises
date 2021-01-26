# Terraform exercises
Terraform exercises

## Exercises list

<details>
<summary>Deploy EC2 instance</summary>

**Task:**
- deploy EC2 instance with Terraform

**Directory**: `deploy-ec2`
<details>
<summary>Create configuration file</summary>

```bash
touch server.tf
```
</details>

<details>
<summary>Use AWS provider</summary>

```hcl
provider "aws" {
  region = "eu-central-1"
}
```
</details>

<details>
<summary>Add EC2 instance</summary>

- use `resource "<PROVIDER>_<RESOURCE_TYPE>" "<LOCAL_NAME>" {}` syntax
- use arguments:
  - `ami`
  - `instance_type`
</details>
</details>
