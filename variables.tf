variable "app_name" {}
variable "app_password" {}

variable "database_login" {}
variable "database_password" {}

variable "agent_count" {
  default = 1
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
  default = "mediawiki"
}

variable "cluster_name" {
  default = "mediawiki"
}

variable "resource_group_name" {
  default = "mediawiki"
}

variable "location" {
  default = "Central India"
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 1
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
  default     = null
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}