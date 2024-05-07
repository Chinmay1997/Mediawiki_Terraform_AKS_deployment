**This Repo is contains code required to deploy MediaWiki to Azure using Terraform and Azure devops. **

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

### Deploy Application using Azure Devops

Create Azure Devops pipeline to build docker images and push image to Azure Container Registry. 
Deploy Application from Azure Devops pipeline using new container image to previously deployed Azure Kubernetes Service. 

**`Use DockerMediawiki to intially build container image.`**

**`Azure devops pipeline file is azure-pipelines.yml`**

**/Manifests/ contains the Application deployment yaml files**

