resource "azurerm_virtual_network" "default" {
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.mediawiki.location
  name                = "vnet-mediawiki"
  resource_group_name = azurerm_resource_group.mediawiki.name
}

resource "azurerm_subnet" "dbsubnet" {
  address_prefixes     = ["10.0.2.0/24"]
  name                 = "subnet-mediawiki-db"
  resource_group_name  = azurerm_resource_group.mediawiki.name
  virtual_network_name = azurerm_virtual_network.default.name
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "fs"

    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_subnet" "compute" {
  address_prefixes     = ["10.0.1.0/24"]
  name                 = "subnet-compute"
  resource_group_name  = azurerm_resource_group.mediawiki.name
  virtual_network_name = azurerm_virtual_network.default.name
  service_endpoints    = ["Microsoft.Storage"]
}

resource "azurerm_private_dns_zone" "default" {
  name                = "mediawiki.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.mediawiki.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "default" {
  name                  = "mysqlfsVnetZonemediawiki.com"
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  resource_group_name   = azurerm_resource_group.mediawiki.name
  virtual_network_id    = azurerm_virtual_network.default.id

  depends_on = [azurerm_subnet.dbsubnet]
}