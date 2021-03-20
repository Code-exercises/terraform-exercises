# Run HTTP server

**Task:**
- deploy EC2 instance with HTTP server
- output IP address

![http server](02-http-server/http-server.png)

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