resource "azurerm_storage_account" "db" {
    for_each = var.sharma
  name                     = each.value.name_storage
  resource_group_name      = each.value.name_rg
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}

resource "azurerm_mssql_server" "sqlservel" {
    for_each = var.sharma
  name                         = each.value.name_sqlserver
  resource_group_name          = each.value.name_rg
  location                     = each.value.location
  version                      = "12.0"
  administrator_login          = each.value.administrator_login
  administrator_login_password = each.value.administrator_login_password
}

resource "azurerm_mssql_database" "sqldb" {
    for_each = var.sharma
  name           = each.value.name_sqldb
  server_id      = azurerm_mssql_server.sqlservel[each.key].id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  read_scale     = false
  sku_name       = "S0"
  

  
}