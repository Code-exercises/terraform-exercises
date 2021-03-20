# Deploy HTTP server using AWS S3 as remote backend

**Task:**
- deploy HTTP server using AWS S3 as remote backend

**Directory:** `remote-backend`

<details>
<summary>Solution</summary>

<details>
<summary>Create directory structure</summary>

```text
- prod
  - services
    - http-server
      - variables.tf
      - outputs.tf
      - main.tf
- global
  - s3
    - outputs.tf
    - main.tf
```
</details>

<details>
<summary>Use AWS provider</summary>

- use `eu-central-1` region
</details>

<details>
<summary>Create S3 Bucket for storing state file</summary>

- set `bucket` (name on AWS side) - must be globally unique
- use `prevent_destroy` lifecycle setting
- enable versioning
- use AES256 server-side encryption
</details>

<details>
<summary>Create DynamoDB table for locking</summary>

- set name
- set billing mode
- set hash key
- set attribute
</details>

<details>
<summary>Apply changes</summary>

- apply changes to create infrastructure for remote backend
</details>

<details>
<summary>Add S3 backend configuration to separate file</summary>

- set `bucket` value - bucket name
- set region
- set DynamoDB table name
- encrypt bucket
</details>

<details>
<summary>Add path to state file to <code>terraform</code> block</summary>

- set `key` - state file path
</details>

<details>
<summary>Init terraform to copy state to remote backend</summary>

- use `terraform init -backend-config=backend.hcl` command
- local backend will be copied to S3
</details>

<details>
<summary>Add outputs</summary>

- S3 Bucket arn
- DynamoDB table name
</details>

</details>