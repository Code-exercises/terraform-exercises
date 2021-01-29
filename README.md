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
<hr>
</details>
<details>
<summary>Run HTTP server</summary>

**Task:**
- deploy EC2 instance with HTTP server
- output IP address

![http server](./http-server/http-server.png)

**Directory**: `http-server`

<details>
<summary>Use aws provider</summary>

```hcl
provider "aws" {
  region = "eu-central-1"
}
```
</details>

<details>
<summary>Add AMI data source</summary>

- use arguments:
  - `owners`
  - `most_recent`
  - `filter` block by name

```hcl
data "aws_ami" "ubuntu" {
  owners = ["099720109477"] # AWS account ID of Canonical
  most_recent = true
  filter = {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}
```
</details>

<details>
<summary>Add security group resource</summary>

- use arguments:
  - `name` - name of the security group
  - `ingress` - incoming traffic configuration
    - `from_port` - `to_port` - open ports range
    - `protocol`
    - `cidr_blocks` - CIDR block for incoming IP addresses
</details>

<details>
<summary>Add EC2 instance</summary>

- `ami` - use from resource
- `instance_type`
- `vpc_security_group_ids` - use `id` of previously created security group  
- `user_data` - for running custom script after deploying, use heredoc syntax  
- `tags.Name` - name on AWS
</details>

<details>
<summary>Use input variable for port</summary>

- use `varaible` syntax
  - `description`
  - `default`
  - `type`
- use variable reference (`var.<VARIABLE_NAME>`) in security group
- use interpolation `"${...}"` in `user_data`
</details>

<details>
<summary>Use output for instance IP</summary>

- use `output "<NAME>" {value, description}` syntax
</details>

<hr>
</details>

<details>
<summary>Create cluster of web servers</summary>

**Task:**
- deploy cluster of http servers

![cluster of http servers](http-server-cluster/http-server-cluster.drawio.png)

**Directory**: `http-server-cluster`

<details>
<summary>Solution</summary>

<details>
<summary>Use AWS provider</summary>

- use `provider "<PROVIDER_NAME>" {}` syntax
- use `eu-cental-1` region
</details>

<details>
<summary>Create AMI Data source for Launch Configuration</summary>

- use `data "<PROVIDER>_<DATASOURCE_TYPE>" "LOCAL_NAME"` syntax
- use Canonical owner id
- use most recent image
- use Ubuntu 18.04 for name filter
</details>

<details>
<summary>Use input variable for security group http port</summary>

- use `variable "<NAME>" {}` syntax
- use port `8080` as default value
- add description
</details>

<details>
<summary>Create Security Group for Launch Configuration</summary>

- add name
- use port value from variable
- allow incoming traffic from all IPs to port from variable
</details>

<details>
<summary>Create Launch Configuration for Auto Scaling Group</summary>

- use image id from AMI datasource
- use `t2.micro` instance type
- use id of previously created security group
- use `user_data` for starting httpd server with port from variable 

</details>

</details>

<hr>
</details>
