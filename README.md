## Variables

The code uses the following variables:

- `tfe_token` : Your TFE token. There is no default value set, you will be prompted.
- `organization` : Your Terraform Cloud organization. There is no default value set, you will be prompted.
- `email` : Email needed for organization creation. There is no default value set, you will be prompted.
- `github_token` : Personal Access Token for accessing the GitHub repository.

> Note: `github_token` is **sensitive** and must be provided in a `.tfvars` file.

## `terraform.tfvars` file

1. You will receive a separate `terraform.tfvars` file via email containing `github_token`.  
2. Place the file in the root of this repository, before running it.

## How to run

1. Clone this repository:

```bash
git clone https://github.com/martz-bg/interview-tf.git
cd interview-tf
terraform init
terraform plan
terraform apply