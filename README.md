**This Repo is contains code required to deploy MediaWiki to Azure using Terraform and Azure devops. 
**
Dockerfile used for image build is **DockerMediawiki**


## Prerequisites

* [Terraform](https://www.terraform.io)
* [Azure subscription](https://azure.microsoft.com/en-us/free)
* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

## How to use

With Terraform and Azure CLI properly configured, you can run:

### `az login`

Authenticate to your Azure account.

### `terraform init`

Prepare your working directory.

### `terraform plan`

Generate an execution plan.

### `terraform apply`

Apply changes to Azure cloud.
