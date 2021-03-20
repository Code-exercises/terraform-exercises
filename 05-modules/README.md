# Deploy HTTP server using modules

**Task:**
- deploy HTTP server to stage and prod environments using modules

**Directory:** `modules`

<details>
<summary>Solution</summary>

<details>
<summary>Directory structure</summary>

```text
- modules
  - http-server
    - variables.tf
    - outputs.tf
    - main.tf
    - user-data.sh
- stage
  - http-server
- prod
  - http-server
- global
  - s3
    - outputs.tf
    - main.tf
```

</details>

<details>
<summary>Initialize remote backend</summary>

- create S3 Bucket and DynamoDB table for remote backend
- initialize remote desktop
    - uncomment backend configuration
      ```hcl
      backend "s3" {
        key = "global/s3/terraform.tfstate"
      }
      ```
    - initialize
      ```bash
      terraform init -backend-config=backend.hcl
      ```
</details>

<details>
<summary>Create HTTP server module</summary>

- don't use `provider` block
- don't use `terraform` block
- use `path.module` for template
- use separate resource for Security Group Rule
</details>

<details>
<summary>Create HTTP server on Stage</summary>

- use `http-server` module
- pass parameters to module
- initialize Terraform with remote backend
  ```bash
  terraform init -backend-config=../../global/s3/backend.hcl
  ```
- use outputs from module
- create additional Security Group Rule in stage configuration
</details>

</details>