# Learn Terraform Get Started AWS

Learn terraform and prepare for AWS certified developer associate exam.

## Terraform Commands

Each AWS service folder is its own Terraform root module, so run commands from the project root using the `-chdir` flag.

- terraform -chdir=ec2 init
- terraform -chdir=ec2 plan
- terraform -chdir=ec2 apply
- terraform -chdir=ec2 destroy

(replace `ec2` with the service folder you want to target, e.g. `alb`, `ebs`, `efs`, `docker`)

## Terraform Version

Terraform version is managed with [mise](https://mise.jdx.dev/).

- mise install
- terraform version
