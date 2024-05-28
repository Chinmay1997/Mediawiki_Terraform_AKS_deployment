resource "azurerm_virtual_network" "default" {
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.mediawiki.location
  name                = "vnet-mediawiki"
  resource_group_name = azurerm_resource_group.mediawiki.name
}

resource "azurerm_route_table" "vnet_priv_rt" {
  name                          = "vnet_priv_rt"
  location                      = azurerm_resource_group.mediawiki.location
  resource_group_name           = azurerm_resource_group.mediawiki.name
  disable_bgp_route_propagation = false

  route {
    name           = "internal route"
    address_prefix = "10.0.0.0/16"
    next_hop_type  = "VnetLocal"
  }
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

resource "azurerm_subnet" "public_subnet" {
  address_prefixes     = ["10.0.3.0/24"]
  name                 = "public_subnet"
  resource_group_name  = azurerm_resource_group.mediawiki.name
  virtual_network_name = azurerm_virtual_network.default.name
  service_endpoints    = ["Microsoft.Storage"]
}

resource "azurerm_subnet_route_table_association" "db_subnet" {
  subnet_id      = azurerm_subnet.compute.id
  route_table_id = azurerm_route_table.vnet_priv_rt.id
}

resource "azurerm_subnet_route_table_association" "compute_subnet" {
  subnet_id      = azurerm_subnet.dbsubnet.id
  route_table_id = azurerm_route_table.vnet_priv_rt.id
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
