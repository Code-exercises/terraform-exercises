# Deploy EC2 instance

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
<summary>Add AWS AMI Datasource</summary>

- use `data "<PROVIDER>_<DATASOURCE_TYPE>" "<NAME>" {}` syntax
</details>

<details>
<summary>Add EC2 instance</summary>

- use `resource "<PROVIDER>_<RESOURCE_TYPE>" "<LOCAL_NAME>" {}` syntax
- use arguments:
    - `ami` use datasource reference syntax - `data.<PROVIDER>_<TYPE>.<NAME>.<ATTRIBUTE>`
    - `instance_type`
    - `tags.Name` - set EC2 instance name
</details>

<details>
<summary>Initialize providers</summary>

```bash
terraform init
```
</details>

<details>
<summary>Plan deployment</summary>

```bash
terraform plan
```
</details>

<details>
<summary>Apply deployment</summary>

```bash
terraform apply
```
</details>

<details>
<summary>Destroy deployment</summary>

```bash
terraform destroy
```
</details>