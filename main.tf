terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.51"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = ">=1.4.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.0.3"
    }
    
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.mediawiki.kube_config.0.host
  client_key             = base64decode(azurerm_kubernetes_cluster.mediawiki.kube_config.0.client_key)
  client_certificate     = base64decode(azurerm_kubernetes_cluster.mediawiki.kube_config.0.client_certificate)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.mediawiki.kube_config.0.cluster_ca_certificate)
}

resource "azurerm_resource_group" "mediawiki" {
  name     = var.resource_group_name
  location = var.location
}
resource "random_string" "name" {
  length  = 8
  lower   = true
  numeric = false
  special = false
  upper   = false
}

