resource "azurerm_mysql_flexible_server" "default" {
  location                     = azurerm_resource_group.mediawiki.location
  name                         = "mysqlfs-mediawikidb"
  resource_group_name          = azurerm_resource_group.mediawiki.name
  administrator_login          = var.database_login
  administrator_password       = var.database_password
  backup_retention_days        = 7
  delegated_subnet_id          = azurerm_subnet.dbsubnet.id
  geo_redundant_backup_enabled = false
  private_dns_zone_id          = azurerm_private_dns_zone.default.id
  sku_name                     = "GP_Standard_D2ds_v4"
  version                      = "8.0.21"

  high_availability {
    mode                      = "SameZone"
  }
  maintenance_window {
    day_of_week  = 0
    start_hour   = 8
    start_minute = 0
  }
  storage {
    iops    = 360
    size_gb = 20
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.default]
}

resource "azurerm_mysql_flexible_database" "main" {
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"
  name                = "mysqlfsdb"
  resource_group_name = azurerm_resource_group.mediawiki.name
  server_name         = azurerm_mysql_flexible_server.default.name
}

